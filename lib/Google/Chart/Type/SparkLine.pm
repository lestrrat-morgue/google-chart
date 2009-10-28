
package Google::Chart::Type::SparkLine;
use Moose;
use namespace::clean -except => qw(meta);

extends 'Google::Chart';
with qw(
    Google::Chart::WithAxis
    Google::Chart::WithData 
    Google::Chart::WithGrid
    Google::Chart::WithLineStyle
    Google::Chart::WithRangeMarker
);

sub _build_type { 'ls' }

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

Google::Chart::Type::SparkLine - Google::Chart SparkLine Type

=cut