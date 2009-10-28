
package Google::Chart::Type::Radar;
use Moose;
use namespace::clean -except => qw(meta);

extends 'Google::Chart';
with qw(
    Google::Chart::WithAxis
    Google::Chart::WithData 
    Google::Chart::WithGrid
    Google::Chart::WithLineStyle
);

has use_smooth_line => (
    is => 'ro',
    isa => 'Bool',
    default => 0,
);

sub _build_type {
    my $self = shift;
    return $self->use_smooth_line ? 'rs' : 'r';
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME 

Google::Chart::Type::Radar - Google::Chart Radar Type

=cut

