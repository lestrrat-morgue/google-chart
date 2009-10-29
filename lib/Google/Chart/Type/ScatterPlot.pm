
package Google::Chart::Type::ScatterPlot;
use Moose;
use namespace::clean -except => qw(meta);

extends 'Google::Chart';
with qw(
    Google::Chart::WithAxis
    Google::Chart::WithData 
    Google::Chart::WithGrid
    Google::Chart::WithMarker
    Google::Chart::WithRangeMarker
    Google::Chart::WithSolidFill
);

sub _build_type { 's' }

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME 

Google::Chart::Type::ScatterPlot - Google::Chart ScatterPlot Type

=cut
