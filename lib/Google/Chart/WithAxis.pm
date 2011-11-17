
package Google::Chart::WithAxis;
use Moose::Role;
use Google::Chart::Types;
use namespace::clean -except => qw(meta);

has axes => (
    traits => ['Array'],
    is => 'ro',
    isa => 'ArrayRef[Google::Chart::Axis]',
    required => 1,
    lazy_build => 1,
);

sub _build_axes { [] }

sub add_axis {
    my $self = shift;
    push @{$self->axes}, Google::Chart::Axis->new(@_);
}

around prepare_query => sub {
    my ($next, $self, @args) = @_;
    my @query = $next->($self, @args);

    my $count = 0;
    my %query = (
        chxt => [],
        chxl => [],
        chxp => [],
        chxr => [],
        chxs => [],
    );
    foreach my $axis (@{ $self->axes }) {
        push @{$query{chxt}}, $axis->location;
        if (my @labels = $axis->labels) {
            push @{$query{chxl}}, join('|', "$count:", map { defined $_ ? $_ : '' } @labels);
        }
        if (my @label_positions = $axis->label_positions) {
            push @{$query{chxp}}, join(',', $count, @label_positions);
        }
        if (my @range = $axis->range) {
            push @{$query{chxr}}, join(',', $count, @range);
        }
        if ($axis->has_color || $axis->has_font_size || $axis->has_alignment) {
            my @args = ( $axis->color );
            push @args, $axis->font_size if $axis->font_size;
            push @args, $axis->alignment if $axis->alignment;
            push @{$query{chxs}}, join(',', $count, @args);
        }
        $count++;
    }

    foreach my $comp (qw( chxt )) {
        my $list = delete $query{ $comp };
        if (scalar @$list > 0) {
            $query{ $comp } = join(',', @$list);
        }
    }
        
    foreach my $comp (qw( chxl chxp chxr chxs )) {
        my $list = delete $query{ $comp };
        if (scalar @$list > 0) {
            $query{ $comp } = join('|', @$list);
        }
    }

    push @query, %query;
    return @query;
};

package # hide from PAUSE
    Google::Chart::Axis;
use Moose;
use Moose::Util::TypeConstraints;
use namespace::clean -except => qw(meta);

has location => (
    is => 'ro',
    isa => enum([ qw( x y r t ) ] ),
    required => 1,
);

has labels => (
    is => 'ro',
    isa => 'ArrayRef[Str|Undef]',
    auto_deref => 1,
);

has label_positions => (
    is => 'ro',
    isa => 'ArrayRef[Num]',
    auto_deref => 1,
);

has range => (
    is => 'ro',
    isa => 'ArrayRef[Num]', # XXX should validate @range == 2
    auto_deref => 1,
);

has color => (
    is => 'ro',
    isa => 'Str',
    predicate => 'has_color',
);

has font_size => (
    is => 'ro',
    isa => 'Num',
    predicate => 'has_font_size',
);

has alignment => (
    is => 'ro',
    isa => enum([ qw(-1 0 1) ] ),
    predicate => 'has_alignment',
);

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

Google::Chart::WithAxis - Charts With Axis

=head1 SYNOPSIS

    my $chart = Google::Chart->create( ... );

    $chart->add_axis(
        location        => 'x',              # 'x', 'y', 'r', or 't'
                                             # optional parameters
        alignment       => 0,                #  -1, 0, or 1
        color           => $hexcolor,        # color of this axis
        font_size       => $points,          # font size
        labels          => \@labels,         # labels for this axis
        label_positions => \@positions,      # posisions
        range           => [ $start, $end ], # range start and end
    );

    # multiple axis can be added
    $chart->add_axis( ... );
    $chart->add_axis( ... );
    $chart->add_axis( ... );

=head1 ATTRIBUTES 

=head2 axes

Individual Axis objects. You probably shouldn't be touching this.

=head1 METHODS

=head2 prepare_query

Hooks to Google::Chart->prepare_query().

=cut
