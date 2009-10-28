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

1;
