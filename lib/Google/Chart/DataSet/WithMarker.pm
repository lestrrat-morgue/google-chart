package Google::Chart::DataSet::WithMarker;
use Moose::Role;
use Moose::Util::TypeConstraints;
use namespace::clean -except => qw(meta);

has marker_type => (
    is => 'ro',
    isa => enum([ qw(a c d o s t v V h x) ]),
    predicate => 'has_marker_type',
);

has marker_color => (
    is => 'ro',
    isa => 'Str',
    predicate => 'has_marker_color',
);

has marker_size => (
    is => 'ro',
    isa => 'Int',
    predicate => 'has_marker_size',
);

has marker_points => (
    is => 'ro',
    isa => 'ArrayRef',
    predicate => 'has_marker_points',
);

has marker_priority => (
    is => 'ro',
    isa => 'Int',
    predicate => 'has_marker_priority'
);

1;
