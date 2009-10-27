use strict;
use Test::More;
use Google::Chart;
use URI;

{ # line chart
    my $uri = URI->new("http://chart.apis.google.com/chart?cht=lc&chs=200x125&chd=s:fooZaroo");
    
    my $g = Google::Chart->new(
        type => 'Line',
        size => '200x125',
        data => Google::Chart::Data->new(
            encoding => 'Simple',
            data     => [ 31, 40, 40, 25, 26, 43, 40, 40 ],
        )
    );

    is_deeply( { $uri->query_form }, { $g->as_uri->query_form });
}

{ # bar chart

    my $uri = URI->new("http://chart.apis.google.com/chart?cht=bhs&chs=200x125&chd=s:ello&chco=4d89f9");

    my $g = Google::Chart->new(
        color => '4d89f9',
        data => Google::Chart::Data->new(
            encoding => 'Simple',
            data     => [ 30, 37, 37, 40 ],
        ),
        size => '200x125',
        type => [ 'Bar' => ( orientation => 'horizontal' ) ], 
    );

    is_deeply( { $uri->query_form }, { $g->as_uri->query_form });
}

{ # color example (1)
    my $uri = URI->new("http://chart.apis.google.com/chart?cht=lc&chco=ff0000,00ff00,0000ff&chs=200x125&chd=s:FOETHECat,lkjtf3asv,KATYPSNXJ&chxt=x,y&chxl=0:|Oct|Nov|Dec|1:||20K||60K||100K");

    my $g = Google::Chart->new(
        axis => Google::Chart::Axis->new(
            axes => [
                Google::Chart::Axis::Item->new(
                    location => 'x',
                    labels => [ 'Oct', 'Nov', 'Dec' ],
                ),
                Google::Chart::Axis::Item->new(
                    location => 'y',
                    labels => [ undef, '20K', undef, '60K', undef, '100K' ],
                )
            ]
        ),
        color => [ 'ff0000', '00ff00', '0000ff' ],
        data => Google::Chart::Data->new(
            encoding => 'Simple',
            data     => [
                [ 5, 14, 4, 19, 7, 4, 2, 26, 45, ],
                [ 37, 36, 35, 45, 31, 55, 26, 44, 47 ],
                [ 10, 0, 19, 24, 15, 18, 13, 23, 9 ]
            ]
        ),
        size => '200x125',
        type => 'Line',
    );

    is_deeply( { $uri->query_form }, { $g->as_uri->query_form });
}

{ # color example (2)
    my $uri = URI->new("http://chart.apis.google.com/chart?cht=ls&chco=ff0000,0000ff&chs=200x125&chd=s:FOETHECat,lkjtf3asv,KATYPSNXJ");

    my $g = Google::Chart->new(
        color => [ 'ff0000', '0000ff' ],
        data => Google::Chart::Data->new(
            encoding => 'Simple',
            data     => [
                [ 5, 14, 4, 19, 7, 4, 2, 26, 45, ],
                [ 37, 36, 35, 45, 31, 55, 26, 44, 47 ],
                [ 10, 0, 19, 24, 15, 18, 13, 23, 9 ]
            ]
        ),
        size => '200x125',
        type => 'SparkLine',
    );

    is_deeply( { $uri->query_form }, { $g->as_uri->query_form });
}

done_testing;
