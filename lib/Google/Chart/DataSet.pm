package Google::Chart::DataSet;
use Moose;
use namespace::clean -except => qw(meta);

has legend => (
    is => 'ro',
    isa => 'Str',
    predicate => 'has_legend'
);

has data => (
    is => 'ro',
    isa => 'ArrayRef',
    required => 1,
);

__PACKAGE__->meta->make_immutable();

1;

__END__

=head1 NAME

Google::Chart::DataSet - A Single Data Set

=cut
