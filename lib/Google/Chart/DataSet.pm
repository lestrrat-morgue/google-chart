package Google::Chart::DataSet;
use Moose;
use namespace::clean -except => qw(meta);

has color => (
    is => 'ro',
    isa => 'Str',
    predicate => 'has_color'
);

has data => (
    is => 'ro',
    isa => 'ArrayRef',
    required => 1,
);

has legend => (
    is => 'ro',
    isa => 'Str',
    predicate => 'has_legend'
);

has max_value => (
    is => 'ro',
    isa => 'Int',
    predicate => 'has_max_value',
);

has min_value => (
    is => 'ro',
    isa => 'Int',
    predicate => 'has_min_value',
);

sub as_query {
    my $self = shift;

    my %query = ();
}

__PACKAGE__->meta->make_immutable();

1;

__END__

=head1 NAME

Google::Chart::DataSet - A Single Data Set

=cut
