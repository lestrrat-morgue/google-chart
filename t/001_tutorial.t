use strict;
use Test::More;
use Google::Chart;
use Google::Chart::Type::Bar;
use URI::QueryParam;

# XXX This tutorial was never finished...

{ # simple creation
    my $g = Google::Chart->create(
        Bar => (
            width  => 200,
            height => 400,
            title => Google::Chart::Title->new( text => "Test Chart" ),
        )
    );
    $g->add_dataset( 
        data => [ 1, 2, 3, 4, 5 ]
    );

    check_simple( $g );
}

{ # same thing with implicit coercion
    my $g = Google::Chart->create(
        Bar => (
            size => '200x400',
            title => 'Test Chart',
        )
    );
    $g->add_dataset(
        data => [ 1, 2, 3, 4, 5 ],
    );

    check_simple($g);
}

sub check_simple {
    local $Test::Builder::Level = $Test::Builder::Level + 1;

    my $g = shift;

    my $uri = $g->as_uri();
    is( $uri->query_param('chtt'), 'Test Chart', 'chart title is "Test Chart"') ;
    is( $uri->query_param('cht'), 'bvg', "chart type is bvs" );
    is( $uri->query_param('chs'), '200x400', "chart size is 200x400" );
    is( $uri->query_param('chd'), 't:1.0,2.0,3.0,4.0,5.0', "chart data is 1,2,3,4,5");
}

done_testing;