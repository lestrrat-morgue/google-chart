use strict;
use Test::More (tests => 7);
use Test::Exception;

BEGIN
{
    use_ok("Google::Chart");
}

{
    my $chart = Google::Chart->create( 
        Line => (
            size => "400x300",
        )
    );
    $chart->add_dataset(
        data => [ 1, 2, 3, 4, 5 ],
    );
    $chart->add_axis(
        location => 'x',
        labels   => [ '1', '50', '100' ],
    );
    $chart->add_axis(
        location => 'y',
        labels   => [ 'x', 'y', 'z' ],
    );
    $chart->add_axis(
        location => 't',
        labels   => [ 'A', 'B', 'C' ],
    );

    ok( $chart );
    isa_ok( $chart, "Google::Chart" );

    is( $chart->size->width, 400 );
    is( $chart->size->height, 300 );

    my $uri = $chart->as_uri;
    note $uri;
    my %h = $uri->query_form;
    is( $h{cht}, "lc" );
    is( $h{chs}, "400x300" );
}
