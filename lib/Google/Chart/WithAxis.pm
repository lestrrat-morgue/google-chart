
package Google::Chart::WithAxis;
use Moose::Role;
use Google::Chart::Axis::Item;
use Google::Chart::Types;
use namespace::clean -except => qw(meta);

has axes => (
    traits => ['Array'],
    is => 'ro',
    isa => 'ArrayRef[Google::Chart::Axis::Item]',
    required => 1,
    lazy_build => 1,
);

sub _build_axes { [] }

sub add_axis {
    my $self = shift;
    push @{$self->axes}, Google::Chart::Axis::Item->new(@_);
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
            push @{$query{chxp}}, join(',', "$count:", @label_positions);
        }
        if (my @range = $axis->range) {
            push @{$query{chxr}}, join(',', $count, @range);
        }
        if (my $style = $axis->style) {
            push @{$query{chxs}}, join(',', $style->color, $style->font_size, $style->alignment);
        }
        $count++;
    }

    foreach my $comp qw( chxt ) {
        my $list = delete $query{ $comp };
        if (scalar @$list > 0) {
            $query{ $comp } = join(',', @$list);
        }
    }
        
    foreach my $comp qw( chxl chxp chxr chxs ) {
        my $list = delete $query{ $comp };
        if (scalar @$list > 0) {
            $query{ $comp } = join('|', @$list);
        }
    }

    push @query, %query;
    return @query;
};

1;

__END__

=head1 NAME

Google::Chart::WithAxis - Google::Chart Axis Specification 

=head1 METHODS

=head2 as_query

=cut
