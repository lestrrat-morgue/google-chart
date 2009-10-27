
package Google::Chart::Axis;
use Moose;
use Google::Chart::Types;
use namespace::clean -except => qw(meta);

with 'Google::Chart::QueryComponent';

has axes => (
    is => 'ro',
    isa => 'ArrayRef[Google::Chart::Axis::Position]',
    required => 1,
);


sub as_query {
    my $self = shift;

    return (chxt => join(',', @{$self->axes}));
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

Google::Chart::Axis - Google::Chart Axis Specification 

=head1 METHODS

=head2 as_query

=cut
