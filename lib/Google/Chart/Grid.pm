
package Google::Chart::Grid;
use Moose;
use Moose::Util::TypeConstraints;
use namespace::clean -except => qw(meta);

with 'Google::Chart::QueryComponent';

coerce 'Google::Chart::Grid'
    => from 'HashRef'
    => via {
        Google::Chart::Grid->new(%{$_});
    }
;


has x_step_size => (
    is => 'ro',
    isa => 'Num',
    required => 1,
    default => 20,
);

has y_step_size => (
    is => 'ro',
    isa => 'Num',
    required => 1,
    default => 20,
);

has line_length => (
    is => 'ro',
    isa => 'Num',
    required => 1,
    default => 1,
);

has blank_length => (
    is => 'ro',
    isa => 'Num',
    required => 1,
    default => 1,
);

sub as_query {
    my $self = shift;

    return (chg => join(',', map { $self->$_ } qw(x_step_size y_step_size line_length blank_length)));
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

Google::Chart::Grid - Google::Chart Grid Specification 

=head1 METHODS

=head2 as_query

=cut
