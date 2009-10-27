use strict;
use lib "t/lib";
use Test::More (tests => 16);
use Test::Google::Chart qw(test_render);

use_ok "Google::Chart::Type::Bar";

{ # Bar
    my $chart = Google::Chart->new(
        size => "400x300",
        data => [ 1, 2, 3, 4, 5 ],
        type => Google::Chart::Type::Bar->new(
            width => 10,
            bar_space => 20,
            group_space => 5,
        )
    );

    ok( $chart );
    isa_ok( $chart, "Google::Chart" );

    isa_ok( $chart->type, "Google::Chart::Type::Bar" );

    is( $chart->size->width, 400 );
    is( $chart->size->height, 300 );

    my $uri = $chart->as_uri;
    note $uri;
    my %h = $uri->query_form;
    is( $h{cht}, "bvs" );
    is( $h{chs}, "400x300" );
    is( $h{chbh}, "10,20,5");

    test_render( $chart );
}

{ # Bar
    my $chart = Google::Chart->new(
        type => {
            module => "Bar",
            args => {
                stacked => 0,
                orientation => 'horizontal'
            }
        },
        size => "400x300",
        data => [ 1, 2, 3, 4, 5 ],
    );

    ok( $chart );
    isa_ok( $chart, "Google::Chart" );

    my $uri = $chart->as_uri;
    note $uri;
    my %h = $uri->query_form;
    is( $h{cht}, "bhg" );
    is( $h{chs}, "400x300" );

}



