use strict;
use lib "t/lib";
use Test::More (tests => 10);
use Test::Google::Chart qw(test_render);


{ # Pie
    my $chart = Google::Chart->create(
        Pie => (
            size => "400x300",
        )
    );
    $chart->add_labels( "um", "dois", "tres", "quatro", "cinco" );
    $chart->add_dataset(
        data => [ 1, 2, 3, 4, 5 ],
    );

    ok( $chart );
    isa_ok( $chart, "Google::Chart" );

    is( $chart->width, 400 );
    is( $chart->height, 300 );

    my $uri = $chart->as_uri;
    note $uri;
    my %h = $uri->query_form;
    is( $h{cht}, "p" );
    is( $h{chs}, "400x300" );
    is( $h{chl}, "um|dois|tres|quatro|cinco" );

    test_render($chart);
}

