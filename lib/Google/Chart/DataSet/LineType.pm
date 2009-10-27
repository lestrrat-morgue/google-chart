package Google::Chart::DataSet::LineType;
use Moose;
use namespace::clean -except => qw(meta);

extends 'Google::Chart::DataSet';

has thickness => (
    is => 'ro',
    isa => 'Num',
    predicate => 'has_thickness',
);

has line_segment_length => (
    is => 'ro',
    isa => 'Num',
    predicate => 'has_line_segment_length',
);

has blank_segment_length => (
    is => 'ro',
    isa => 'Num',
    predicate => 'has_blank_segment_length',
);

__PACKAGE__->meta->make_immutable();

1;

