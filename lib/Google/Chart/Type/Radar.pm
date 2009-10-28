
package Google::Chart::Type::Radar;
use Moose;
use Google::Chart::Data::LineType;
use namespace::clean -except => qw(meta);

extends 'Google::Chart';
with qw(
    Google::Chart::WithAxis
    Google::Chart::WithData 
    Google::Chart::WithGrid
);

has use_smooth_line => (
    is => 'ro',
    isa => 'Bool',
    default => 0,
);

sub _build_data {
    return Google::Chart::Data::LineType->new();
}

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

