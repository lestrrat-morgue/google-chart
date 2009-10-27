
package Google::Chart::Type::ScatterPlot;
use Moose;
use namespace::clean -except => qw(meta);

extends 'Google::Chart';

sub _build_type { 's' }

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME 

Google::Chart::Type::ScatterPlot - Google::Chart ScatterPlot Type

=cut
