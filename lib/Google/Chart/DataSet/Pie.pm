package Google::Chart::DataSet::Pie;
use Moose;
use namespace::clean -except => qw(meta);

extends 'Google::Chart::DataSet';

has label => (
    is => 'ro',
    isa => 'Str',
    predicate => 'has_label',
);

__PACKAGE__->meta->make_immutable();

1;