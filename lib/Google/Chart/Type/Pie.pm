
package Google::Chart::Type::Pie;
use Moose;
use Moose::Util::TypeConstraints;
use namespace::clean -except => qw(meta);

extends 'Google::Chart';
with 'Google::Chart::WithData';

has pie_type => (
    is => 'ro',
    isa => enum([ qw(2d 3d) ]),
    required => 1,
    default => '2d'
);

sub _build_type {
    my $self = shift;
    return $self->pie_type eq '3d' ? 'p3' : 'p';
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

Google::Chart::Type::Pie - Google::Chart Pie Chart Type

=head1 SYNOPSIS

  Google::Chart->new(
    type => 'Pie'
  );

  Google::Chart->new(
    type => {
      module => 'Pie',
      args   => {
        pie_type => '3d'
      }
    }
  );

=head1 METHODS

=head2 parameter_value

=cut