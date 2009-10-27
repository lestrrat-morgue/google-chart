use strict;
use lib "t/lib";
use Test::More (tests => 9);
use Test::Google::Chart qw(test_render);


{ # Pie
    my $chart = Google::Chart->create(
        Pie => (
            size => "400x300",
            data => [ 1, 2, 3, 4, 5 ],
        )
    );

    ok( $chart );
    isa_ok( $chart, "Google::Chart" );

    is( $chart->size->width, 400 );
    is( $chart->size->height, 300 );

    my $uri = $chart->as_uri;
    note $uri;
    my %h = $uri->query_form;
    is( $h{cht}, "p" );
    is( $h{chs}, "400x300" );

    test_render($chart);
}

