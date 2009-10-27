use strict;
use Test::More;
use Google::Chart;
use URI;

{ # line chart
    my $uri = URI->new("http://chart.apis.google.com/chart?cht=lc&chs=200x125&chd=s:fooZaroo");
    
    my $g = Google::Chart->create(
        Line => (
            size => '200x125',
        )
    );
    $g->data_encoding( 'Simple' );
    $g->add_dataset(
        data     => [ 31, 40, 40, 25, 26, 43, 40, 40 ],
    );

    note($g->as_uri);
    is_deeply( { $uri->query_form }, { $g->as_uri->query_form });
}

{ # bar chart

    my $uri = URI->new("http://chart.apis.google.com/chart?cht=bhs&chs=200x125&chd=s:ello&chco=4d89f9");

    my $g = Google::Chart->create(
        Bar => (
            orientation => 'horizontal',
            size => '200x125',
        )
    );
    $g->data_encoding('Simple');
    $g->add_dataset(
        color => '4d89f9',
        data => [ 30, 37, 37, 40 ],
    );
    note($g->as_uri);
    is_deeply( { $uri->query_form }, { $g->as_uri->query_form });
}

{ # color example (1)
    my $uri = URI->new("http://chart.apis.google.com/chart?cht=lc&chco=ff0000,00ff00,0000ff&chs=200x125&chd=s:FOETHECat,lkjtf3asv,KATYPSNXJ&chxt=x,y&chxl=0:|Oct|Nov|Dec|1:||20K||60K||100K");

    my $g = Google::Chart->create(
        Line => (
            size => '200x125',
        )
    );
    $g->add_axis(
        location => 'x',
        labels => [ 'Oct', 'Nov', 'Dec' ],
    );
    $g->add_axis(
        location => 'y',
        labels => [ undef, '20K', undef, '60K', undef, '100K' ],
    );
    $g->data_encoding( 'Simple' );
    $g->add_dataset(
        color => 'ff0000',
        data => [ 5, 14, 4, 19, 7, 4, 2, 26, 45, ],
    );
    $g->add_dataset(
        color => '00ff00',
        data => [ 37, 36, 35, 45, 31, 55, 26, 44, 47 ],
    );
    $g->add_dataset(
        color => '0000ff',
        data => [ 10, 0, 19, 24, 15, 18, 13, 23, 9 ]
    );

    note($g->as_uri);
    is_deeply( { $uri->query_form }, { $g->as_uri->query_form });
}

{ # color example (2)
    my $uri = URI->new("http://chart.apis.google.com/chart?cht=ls&chco=ff0000,0000ff&chs=200x125&chd=s:FOETHECat,lkjtf3asv,KATYPSNXJ");

    my $g = Google::Chart->create(
        SparkLine => (
            size => '200x125',
        )
    );
    $g->data_encoding('Simple');
    $g->add_dataset(
        color => 'ff0000',
        data => [ 5, 14, 4, 19, 7, 4, 2, 26, 45, ],
    );
    $g->add_dataset(
        color => '0000ff',
        data => [ 37, 36, 35, 45, 31, 55, 26, 44, 47 ],
    );
    $g->add_dataset(
        data => [ 10, 0, 19, 24, 15, 18, 13, 23, 9 ]
    );

    note($g->as_uri);
    is_deeply( { $uri->query_form }, { $g->as_uri->query_form });
}

{ # radar example (1)
    my $uri = URI->new("http://chart.apis.google.com/chart?cht=r&chs=200x200&chd=t:10.0,20.0,30.0,40.0,50.0,60.0,70.0,80.0,90.0");
    
    my $g = Google::Chart->create(
        Radar => (
            size => "200x200",
        )
    );
    $g->add_dataset(
        data => [ 10, 20, 30, 40, 50, 60, 70, 80, 90 ]
    );

    note($g->as_uri);
    is_deeply( { $uri->query_form }, { $g->as_uri->query_form }, "radar example (1)");

}

{ # radar example (2)

    my $uri = URI->new("http://chart.apis.google.com/chart?cht=r&chs=200x200&chd=t:77.0,66.0,15.0,0.0,31.0,48.0,100.0,77.0|20.0,36.0,100.0,2.0,0.0,100.0&chco=FF0000,FF9900&chls=2.0,4.0,0.0|2.0,4.0,0.0&chxt=x&chxl=0:|0|45|90|135|180|225|270|315&chxr=0,0,360");

    my $g = Google::Chart->create(
        Radar => (
            size => "200x200",
        )
    );
    $g->add_axis(
        location => 'x',
        labels   => [ 0, 45, 90, 135, 180, 225, 270, 315 ],
        range    => [ 0, 360 ]
    );
    $g->add_dataset( 
        data  => [ 77, 66, 15, 0, 31, 48, 100, 77 ],
        thickness => '2.0',
        line_segment_length => '4.0',
        blank_segment_length => '0.0',
        color => 'FF0000',
    );
    $g->add_dataset(
        data => [ 20, 36, 100, 2, 0, 100 ],
        thickness => '2.0',
        line_segment_length => '4.0',
        blank_segment_length => '0.0',
        color => 'FF9900',
    );
    note($g->as_uri);
    is_deeply( { $uri->query_form }, { $g->as_uri->query_form });

}

done_testing;


