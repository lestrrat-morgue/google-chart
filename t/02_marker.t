use strict;
use Test::More (tests => 10);

BEGIN
{
    use_ok("Google::Chart::Marker");
}

{
    my $marker = Google::Chart::Marker->new();
    ok($marker);
    isa_ok($marker, "Google::Chart::Marker");
    is( $marker->marker_type, 'o' );
    is( $marker->color, "000000" );
    is( $marker->dataset, 0 );
    is( $marker->datapoint, -1 );
    is( $marker->size, 5 );
    is( $marker->priority, 0 );

    is( $marker->as_query, "chm=o%2C000000%2C0%2C-1%2C5%2C0" );
}