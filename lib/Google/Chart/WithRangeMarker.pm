package Google::Chart::WithRangeMarker;
use Moose::Role;
use namespace::clean -except => qw(meta);

has range_markers => (
    is => 'ro',
    isa => 'ArrayRef',
    lazy_build => 1,
);

sub _build_range_markers { [] }

sub add_range_marker {
    my ($self, @args) = @_;
    push @{ $self->range_markers }, 
        Google::Chart::RangeMarker->new(@args);
    return $self;
}

around prepare_query => sub {
    my ($next, $self, @args) = @_;

    my @query = $next->($self, @args);
    my $markers = $self->range_markers;
    my $max = scalar @$markers - 1;

    my @chm;
    for my $i (0..$max) {
        my $marker = $markers->[$i];
        push @chm, join(',',
            ($marker->orientation || '') eq 'vertical' ? 'R' : 'r',
            $marker->color,
            0,
            $marker->start,
            $marker->end,
        );
    }

    if (@chm) {
        push @query, (chm => join('|', @chm));
    }

    return @query;
};

package Google::Chart::RangeMarker;
use Moose;
use Moose::Util::TypeConstraints;
use namespace::clean -except => qw(meta);

has orientation => (
    is => 'ro',
    isa => enum([ qw(horizontal vertical) ]),
    predicate => 'has_orientation',
);

has color => (
    is => 'ro',
    isa => 'Str',
    predicate => 'has_color',
);

has start => (
    is => 'ro',
    isa => 'Num',
    predicate => 'has_start',
);

has end => (
    is => 'ro',
    isa => 'Num',
    predicate => 'has_end',
);

__PACKAGE__->meta->make_immutable();

1;
