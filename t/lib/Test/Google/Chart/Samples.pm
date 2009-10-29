package Test::Google::Chart::Samples;
use strict;
use Google::Chart;
my @charts = (
    'http://chart.apis.google.com/chart?cht=p3&chd=t:60,40&chs=250x100&chl=Hello|World' => sub {
        my $g = Google::Chart->create(
            Pie => (
                size => "250x100",
                pie_type => "3d",
            )
        );
        $g->add_dataset(
            data => [ 60, 40 ],
        );
        $g->add_pie_label( 'Hello', 'World' );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=lc&chs=200x100&chd=s:fohmnytenefohmnytene&chxt=x,y&chxl=0:|Apr|May|June|1:||50' => sub {
        my $g = Google::Chart->create(
            Line => (
                size => '200x100',
            )
        );
        $g->data_encoding( 'Simple' );
        $g->add_dataset(
            data => [ qw(31 40 33 38 39 50 45 30 39 30 31 40 33 38 39 50 45 30 39 30) ],
        );
        $g->add_axis(
            location => 'x',
            labels => [ qw(Apr May June) ],
        );
        $g->add_axis(
            location => 'y',
            labels => [ undef, 50 ]
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=lc&chs=200x100&chd=s:frothsmzndyoteepngenfrothsmzndyoteepngen&chxt=x,y&chxl=0:|Apr|May|June|1:||50' => sub {
        my $g = Google::Chart->create(
            Line => (
                size => '200x100',
            )
        );
        $g->data_encoding( 'Simple' );
        $g->add_dataset( data => [ qw(31 43 40 45 33 44 38 51 39 29 50 40 45 30 30 41 39 32 30 39 31 43 40 45 33 44 38 51 39 29 50 40 45 30 30 41 39 32 30 39) ] );
        $g->add_axis(
            location => 'x',
            labels => [ qw(Apr May June) ],
        );
        $g->add_axis(
            location => 'y',
            labels => [ undef, 50 ]
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=lc&chs=200x100&chd=s:formostthisamazingdayfortheleapinggreenlformostthisamazingdayfortheleapinggreenl&chxt=x,y&chxl=0:|Apr|May|June|1:||50' => sub {
        my $g = Google::Chart->create(
            Line => (
                size => '200x100',
            )
        );
        $g->data_encoding( 'Simple' );
        $g->add_dataset( data => [ qw(31 40 43 38 40 44 45 45 33 34 44 26 38 26 51 34 39 32 29 26 50 31 40 43 45 33 30 37 30 26 41 34 39 32 32 43 30 30 39 37 31 40 43 38 40 44 45 45 33 34 44 26 38 26 51 34 39 32 29 26 50 31 40 43 45 33 30 37 30 26 41 34 39 32 32 43 30 30 39 37) ] );
        $g->add_axis(
            location => 'x',
            labels => [ qw(Apr May June) ],
        );
        $g->add_axis(
            location => 'y',
            labels => [ undef, 50 ]
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=lc&chs=200x125&chd=s:fooZaroo' => sub {
        my $g = Google::Chart->create(
            Line => (
                size => '200x125',
            )
        );
        $g->data_encoding( 'Simple' );
        $g->add_dataset( data => [ qw(31 40 40 25 26 43 40 40) ] );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=lxy&chs=200x125&chd=t:0,30,60,70,90,95,100|20,30,40,50,60,70,80|10,30,40,45,52|100,90,40,20,10|-1|5,33,50,55,7&chco=3072F3,ff0000,00aaaa&chls=2,4,1&chm=s,FF0000,0,-1,5|s,0000ff,1,-1,5|s,00aa00,2,-1,5' => sub {
        my $g = Google::Chart->create(
            XY => (
                size => "200x125",
            )
        );
        $g->add_dataset( 
            color => "3072F3",
            data => [ 0,30,60,70,90,95,100 ],
            line_thickness => 2,
            line_segment_length => 4,
            blank_segment_length => 1,
        );
        $g->add_dataset(
            color => "ff0000",
            data => [ 20,30,40,50,60,70,80 ],
        );
        $g->add_dataset(
            color => "00aaaa",
            data => [ 10,30,40,45,52 ],
        );
        $g->add_dataset( data => [ 100,90,40,20,10 ]);
        $g->add_dataset( data => [ -1 ]);
        $g->add_dataset( data => [ 5,33,50,55,7 ] );

        $g->add_marker(
            dataset_index => 0,
            type => 's',
            color => 'FF0000',
            point => -1,
            size => 5,
        );
        $g->add_marker(
            dataset_index => 1,
            type => 's',
            color => '0000ff',
            point => -1,
            size => 5,
        );
        $g->add_marker(
            dataset_index => 2,
            type => 's',
            color => '00aa00',
            point => -1,
            size => 5,
        );

        return $g;
    },
    'http://chart.apis.google.com/chart?chs=100x20&cht=ls&chco=0077CC&chm=B,E6F2FA,0,0,0&chls=1,0,0&chd=t:27,25,25,25,25,27,100,31,25,36,25,25,39,25,31,25,25,25,26,26,25,25,28,25,25,100,28,27,31,25,27,27,29,25,27,26,26,25,26,26,35,33,34,25,26,25,36,25,26,37,33,33,37,37,39,25,25,25,25' => sub {

        my $g = Google::Chart->create(
            SparkLine => (
                size => '100x20',
            ),
        );
        $g->add_dataset(
            color => "0077CC",
            data => [ 27,25,25,25,25,27,100,31,25,36,25,25,39,25,31,25,25,25,26,26,25,25,28,25,25,100,28,27,31,25,27,27,29,25,27,26,26,25,26,26,35,33,34,25,26,25,36,25,26,37,33,33,37,37,39,25,25,25,25 ],
            line_thickness => 1,
            line_segment_length => 0,
            blank_segment_length => 0,
        );
        $g->add_range_fill(
            type => 'B',
            color => 'E6F2FA',
            start_index => 0,
            end_index => 0,
        );

        return $g;
    },
    'http://chart.apis.google.com/chart?cht=bhs&chs=200x125&chd=s:ello&chco=4d89f9' => sub {
        my $g = Google::Chart->create(
            Bar => (
                size => '200x125',
                stacked => 1,
                orientation => 'horizontal',
            )
        );
        $g->data_encoding( 'Simple' );
        $g->add_dataset(
            color => "4d89f9",
            data => [ qw( 30 37 37 40 ) ],
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=bvs&chs=200x125&chd=t:10,50,60,80,40|50,60,100,40,20&chco=4d89f9,c6d9fd&chbh=20' => sub {
        my $g = Google::Chart->create(
            Bar => (
                bar_width => 20,
                size => '200x125',
                stacked => 1,
            )
        );
        $g->add_dataset(
            color => "4d89f9",
            data => [ 10,50,60,80,40 ],
        );
        $g->add_dataset(
            color => "c6d9fd",
            data => [ 50,60,100,40,20 ],
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=bvs&chs=200x125&chd=t:10,50,60,80,40|50,60,100,40,20&chco=4d89f9,c6d9fd&chbh=20&chds=0,160' => sub {
        my $g = Google::Chart->create(
            Bar => (
                bar_width => 20,
                size => '200x125',
                stacked => 1,
                data_encoding => 'Extended',
            )
        );
        $g->add_dataset( 
            color => "4d89f9",
            data => [ 10,50,60,80,40 ],
            min_value => 0,
            max_value => 160,
        );
        $g->add_dataset(
            color => "c6d9fd",
            data => [ 50,60,100,40,20 ],
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=bhg&chs=200x125&chd=s:el,or&chco=4d89f9,c6d9fd' => sub {
        my $g = Google::Chart->create(
            Bar => (
                orientation => 'horizontal',
                size => '200x125',
                encoding_class => 'Simple',
            )
        );
        $g->add_dataset(
            color => '4d89f9',
            data => [ 30, 37 ],
        );
        $g->add_dataset(
            color => 'c6d9fd',
            data => [ 40, 43 ],
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=bvg&chs=200x125&chd=s:hello,world&chco=4d89f9,c6d9fd' => sub {
        my $g = Google::Chart->create(
            Bar => (
                size => '200x125',
                encoding_class => 'Simple',
            )
        );
        $g->add_dataset(
            color => '4d89f9',
            data => [ qw( 33 30 37 37 40 ) ],
        );
        $g->add_dataset(
            color => 'c6d9fd',
            data => [ qw( 48 40 43 37 29 ) ],
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=bhs&chs=200x125&chd=s:hello&chco=4d89f9' => sub {
        my $g = Google::Chart->create(
            Bar => (
                orientation => 'horizontal',
                stacked => 1,
                encoding_class => 'Simple',
                size => '200x125',
            )
        );
        $g->add_dataset(
            color => '4d89f9',
            data => [ qw( 33 30 37 37 40 ) ],
        );
        return $g;

    },
    'http://chart.apis.google.com/chart?cht=bhs&chs=200x125&chd=s:hello&chbh=10&chco=4d89f9' => sub {
        my $g = Google::Chart->create(
            Bar => (
                orientation => 'horizontal',
                stacked => 1,
                bar_width => 10,
                encoding_class => 'Simple',
                size => '200x125',
            )
        );
        $g->add_dataset(
            color => '4d89f9',
            data => [ qw( 33 30 37 37 40 ) ],
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=p&chd=s:Uf9a&chs=200x100&chl=January|February|March|April' => sub {
        my $g = Google::Chart->create(
            Pie => (
                encoding_class => 'Simple',
                size => '200x100',
            )
        );
        $g->add_dataset(
            data => [ 20, 31, 61, 26  ],
        );
        $g->add_pie_label( qw(January February March April) );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=p3&chd=s:Uf9a&chs=250x100&chl=January|February|March|April' => sub {
        my $g = Google::Chart->create(
            Pie => (
                encoding_class => 'Simple',
                size => '250x100',
                pie_type => '3d',
            )
        );
        $g->add_dataset(
            data => [ 20, 31, 61, 26  ],
        );
        $g->add_pie_label( qw(January February March April) );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=v&chs=200x100&chd=t:100,80,60,30,30,30,10' => sub {
        my $g = Google::Chart->create(
            Venn => (
                size => '200x100',
            )
        );
        $g->add_dataset(
            data => [ 100, 80, 60, 30, 30, 30, 10 ] 
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=s&chd=s:984sttvuvkQIBLKNCAIi,DEJPgq0uov17zwopQODS,AFLPTXaflptx159gsDrn&chxt=x,y&chxl=0:|0|2|3|4|5|6|7|8|9|10|1:|0|25|50|75|100&chs=200x125' => sub {
        my $g = Google::Chart->create(
            ScatterPlot => (
                size => '200x125',
                encoding_class => 'Simple',
            )
        );
        $g->add_dataset(
            data => [ qw( 61 60 56 44 45 45 47 46 47 36 16 8 1 11 10 13 2 0 8 34) ],
        );
        $g->add_dataset(
            data => [ qw( 3 4 9 15 32 42 52 46 40 47 53 59 51 48 40 41 16 14 3 18 ) ],
        );
        $g->add_dataset(
            data => [ qw(  0 5 11 15 19 23 26 31 37 41 45 49 53 57 61 32 44 3 43 39 ) ],
        );
        $g->add_axis(
            location => 'x',
            labels => [ qw(0 2 3 4 5 6 7 8 9 10) ],
        );
        $g->add_axis(
            location => 'y',
            labels => [ qw( 0 25 50 75 100 ) ],
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=r&chs=200x200&chd=t:10,20,30,40,50,60,70,80,90' => sub {
        my $g = Google::Chart->create(
            Radar => (
                size => "200x200",
            )
        );
        $g->add_dataset(
            data => [ 10, 20, 30, 40, 50, 60, 70, 80, 90 ]
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=r&chs=200x200&chd=t:77,66,15,0,31,48,100,77|20,36,100,2,0,100&chco=FF0000,FF9900&chls=2.0,4.0,0.0|2.0,4.0,0.0&chxt=x&chxl=0:|0|45|90|135|180|225|270|315&chxr=0,0.0,360.0' => sub {
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
            line_thickness => '2.0',
            line_segment_length => '4.0',
            blank_segment_length => '0.0',
            color => 'FF0000',
        );
        $g->add_dataset(
            data => [ 20, 36, 100, 2, 0, 100 ],
            line_thickness => '2.0',
            line_segment_length => '4.0',
            blank_segment_length => '0.0',
            color => 'FF9900',
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=r&chs=200x200&chd=t:77,66,15,0,31,48,100,77|20,36,100,2,0,100&chco=FF0000,FF9900&chls=2.0,4.0,0.0|2.0,4.0,0.0&chxt=x&chxl=0:|0|45|90|135|180|225|270|315&chxr=0,0.0,360.0&chg=25.0,25.0,4.0,4.0&chm=B,FF000080,0,1.0,5.0|B,FF990080,1,1.0,5.0' => sub {
        my $g = Google::Chart->create(
            Radar => (
                size => '200x200',
                encoding_class => 'Simple',
                grid_x_step_size => 25,
                grid_y_step_size => 25,
                grid_line_length => 4,
                grid_blank_length => 4,
            )
        );
        $g->add_axis(
            location => 'x',
            labels => [ qw( 0 45 90 135 180 225 270 315 ) ],
        );
        $g->add_dataset(
            color => 'FF0000',
            line_thickness => 2,
            line_segment_length => 4,
            blank_segment_length => 0,
            data => [ qw( 47 40 9 0 19 29 61 47 ) ],
        );
        $g->add_dataset(
            color => 'FF9900',
            line_thickness => 2,
            line_segment_length => 4,
            blank_segment_length => 0,
            data => [ qw( 12 22 61 1 0 61 ) ],
        );
        $g->add_range_fill(
            type => 'B',
            color => 'FF000000',
            start_index => 0,
            end_index => 1,
        );
        $g->add_range_fill(
            type => 'B',
            color => 'FF990080',
            start_index => 0,
            end_index => 1,
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=r&chs=200x200&chd=s:voJATd9v,MW9BA9&chco=FF0000,FF9900&chls=2.0,4.0,0.0|2.0,4.0,0.0&chxt=x&chxl=0:|0|45|90|135|180|225|270|315&chxr=0,0.0,360.0&chg=25.0,25.0,4.0,4.0&chm=B,FF000080,0,1.0,5.0|B,FF990080,1,1.0,5.0|h,0000FF,0,1.0,4.0|h,3366CC80,0,0.5,5.0|V,00FF0080,0,1.0,5.0|V,008000,0,5.5,5.0|v,00A000,0,6.5,4' => sub {
        my $g = Google::Chart->create(
            Radar => (
                size => '200x200',
                encoding_class => 'Simple',
                grid_x_step_size => 25,
                grid_y_step_size => 25,
                grid_line_length => 4,
                grid_blank_length => 4,
            )
        );
        $g->add_axis(
            location => 'x',
            labels => [ qw( 0 45 90 135 180 225 270 315 ) ],
        );
        $g->add_dataset(
            color => 'FF0000',
            line_thickness => 2,
            line_segment_length => 4,
            blank_segment_length => 0,
            data => [ qw( 47 40 9 0 19 29 61 47 ) ],
        );
        $g->add_dataset(
            color => 'FF9900',
            line_thickness => 2,
            line_segment_length => 4,
            blank_segment_length => 0,
            data => [ qw( 12 22 61 1 0 61 ) ],
        );
        $g->add_range_fill(
            type => 'B',
            color => 'FF000000',
            start_index => 0,
            end_index => 1,
        );
        $g->add_range_fill(
            type => 'B',
            color => 'FF990080',
            start_index => 0,
            end_index => 1,
        );
        $g->add_marker(
            type => 'h',
            color => '0000FF',
            point => 1,
            size => 4
        );
        $g->add_marker(
            type => 'h',
            color => '3366CC80',
            point => 0.5,
            size => 5
        );
        $g->add_marker(
            type => 'V',
            color => '00FF0080',
            point => 1,
            size => 5,
        );
        $g->add_marker(
            type => 'V',
            color => '008000',
            point => 5.5,
            size => 5,
        );
        $g->add_marker(
            type => 'v',
            color => '00A000',
            point => 6.5,
            size => 4
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=t&chs=440x220&chd=s:_&chtm=world' => sub {
        my $g = Google::Chart->create(
            Map => (
                size => '440x220',
            )
        );
        $g->add_dataset( data => [ undef ] );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=t&chs=440x220&chd=s:Af9&chco=ffffff,edf0d4,13390a&chld=MGKETN&chtm=africa&chf=bg,s,EAF7FE' => sub {
        my $g = Google::Chart->create(
            Map => (
                size => '440x220',
                colors => [ 'ffffff', 'edf0d4', '13390a' ],
                codes => [ qw(MG KE TN) ],
                area => 'africa',
                encoding_class => 'Simple',
            )
        );
        $g->add_solid_fill(
            type => 'bg',
            color => 'EAF7FE',
        );
        $g->add_dataset( data => [ qw(0 31 61) ] );
        return $g;
    },
    'http://chart.apis.google.com/chart?chco=f5f5f5,edf0d4,6c9642,365e24,13390a&chd=s:fSGBDQBQBBAGABCBDAKLCDGFCLBBEBBEPASDKJBDD9BHHEAACAC&chf=bg,s,eaf7fe&chtm=usa&chld=NYPATNWVNVNJNHVAHIVTNMNCNDNELASDDCDEFLWAKSWIORKYMEOHIAIDCTWYUTINILAKTXCOMDMAALMOMNCAOKMIGAAZMTMSSCRIAR&chs=440x220&cht=t' => sub {
        my $g = Google::Chart->create(
            Map => (
                size => '440x220',
                colors => [ qw( f5f5f5 edf0d4 6c9642 365e24 13390a ) ],
                codes => [ qw( NY PA TN WV NV NJ NH VA HI VT NM NC ND NE LA SD DC DE FL WA KS WI OR KY ME OH IA ID CT WY UT IN IL AK TX CO MD MA AL MO MN CA OK MI GA AZ MT MS SC RI AR ) ],
                area => 'usa',
                encoding_class => 'Simple',
            )
        );
        $g->add_solid_fill(
            type => 'bg',
            color => 'EAF7FE',
        );
        $g->add_dataset( data => [ qw( 31 18 6 1 3 16 1 16 1 1 0 6 0 1 2 1 3 0 10 11 2 3 6 5 2 11 1 1 4 1 1 4 15 0 18 3 10 9 1 3 3 61 1 7 7 4 0 0 2 0 2 ) ] );
        return $g;
    },
    'http://chart.apis.google.com/chart?chs=225x125&cht=gom&chd=t:70&chl=Hello' => sub {
        my $g = Google::Chart->create(
            GoogleOMeter => (
                size => '225x125',
                label => 'Hello',
            )
        );
        $g->add_dataset(
            data => [ 70 ]
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?chs=150x150&cht=qr&chl=Hello%20world' => sub {
        my $g = Google::Chart->create(
            QRcode => (
                size => '150x150',
                qrcode_encoding => 'UTF-8',
                text => 'Hello world',
            )
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=lc&chco=ff0000,00ff00,0000ff&chs=200x125&chd=s:FOETHECat,lkjtf3asv,KATYPSNXJ&chxt=x,y&chxl=0:|Oct|Nov|Dec|1:||20K||60K||100K' => sub {
        my $g = Google::Chart->create(
            Line => (
                size => '200x125',
                encoding_class => 'Simple',
            )
        );
        $g->add_axis(
            location => 'y',
            labels => [ undef, '20K', undef, '60K', undef, '100K' ],
        );
        $g->add_axis(
            location => 'x',
            labels => [ qw(Oct Nov Dec) ]
        );
        $g->add_dataset(
            color => 'ff0000',
            data => [ qw(5 14 4 19 7 4 2 26 45 ) ],
        );
        $g->add_dataset(
            color => '00ff00',
            data => [ qw( 37 36 35 45 31 55 26 44 47 ) ],
        );
        $g->add_dataset(
            color => '0000ff',
            data => [ qw( 10 0 19 24 15 18 13 23 9 ) ],
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=ls&chco=ff0000,0000ff&chs=200x125&chd=s:FOETHECat,lkjtf3asv,KATYPSNXJ' => sub {
        my $g = Google::Chart->create(
            SparkLine => (
                size => '200x125',
                encoding_class => 'Simple',
            )
        );
        $g->add_dataset(
            color => 'ff0000',
            data => [ qw(5 14 4 19 7 4 2 26 45 ) ],
        );
        $g->add_dataset(
            color => '0000ff',
            data => [ qw( 37 36 35 45 31 55 26 44 47 ) ],
        );
        $g->add_dataset(
            data => [ qw( 10 0 19 24 15 18 13 23 9 ) ],
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=bhs&chco=ff0000,00ff00&chs=200x125&chd=s:FOE,THE,Bar&chxt=x,y&chxl=1:|Dec|Nov|Oct|0:||20K||60K||100K|' => sub {
        my $g = Google::Chart->create(
            Bar => (
                stacked => 1,
                orientation => 'horizontal',
                size => '200x125',
                encoding_class => 'Simple',
            )
        );
        $g->add_axis(
            location => 'x',
            labels => [ undef, '20K', undef, '60K', undef, '100K', undef, ],
        );
        $g->add_axis(
            location => 'y',
            labels => [ qw(Dec Nov Oct) ]
        );
        $g->add_dataset(
            color => 'ff0000',
            data => [ qw( 5 14 4 ) ],
        );
        $g->add_dataset(
            color => '00ff00',
            data => [ qw( 19 7 4 ) ],
        );
        $g->add_dataset(
            color => 'ff0000',
            data => [ qw( 1 26 43 ) ],
        );
        
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=bhs&chco=ff0000,00ff00,0000ff&chs=200x125&chd=s:FOE,THE,Bar&chxt=x,y&chxl=1:|Dec|Nov|Oct|0:||20K||60K||100K|' => sub {
        my $g = Google::Chart->create(
            Bar => (
                size => '200x125',
                stacked => 1,
                orientation => 'horizontal',
                encoding_class => 'Simple',
            )
        );
        $g->add_axis(
            location => 'x',
            labels => [ undef, '20K', undef, '60K', undef, '100K', undef, ],
        );
        $g->add_axis(
            location => 'y',
            labels => [ qw(Dec Nov Oct) ],
        );
        $g->add_dataset(
            color => 'ff0000',
            data => [ qw( 5 14 4 ) ],
        );
        $g->add_dataset(
            color => '00ff00',
            data => [ qw( 19 7 4 ) ],
        );
        $g->add_dataset(
            color => '0000ff',
            data => [ qw( 1 26 43 ) ],
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=bhs&chco=ff0000|00ff00|0000ff&chs=200x125&chd=s:elo&chxt=x,y&chxl=1:|Dec|Nov|Oct|0:||20K||60K||100K|' => sub {
        my $g = Google::Chart->create(
            Bar => (
                size => '200x125',
                orientation => 'horizontal',
                encoding_class => 'Simple',
            )
        );
        $g->add_axis(
            location => 'x',
            labels => [ undef, '20K', undef, '60K', undef, '100K', undef, ],
        );
        $g->add_axis(
            location => 'y',
            labels => [ qw(Dec Nov Oct) ],
        );
        $g->add_dataset(
            color => 'ff0000',
            data => [ qw( 30 ) ],
        );
        $g->add_dataset(
            color => '00ff00',
            data => [ qw( 37 ) ],
        );
        $g->add_dataset(
            color => '0000ff',
            data => [ qw( 40 ) ],
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=p3&chs=200x90&chd=s:Hellobla&chl=May|Jun|Jul|Aug|Sep|Oct&chco=0000ff' => sub {
        my $g = Google::Chart->create(
            Pie => (
                size => '200x90',
                pie_type => '3d',
                encoding_class => 'Simple',
            )
        );
        $g->add_dataset(
            color => '0000ff',
            data => [ qw(7 30 37 37 40 27 37 26) ],
        );
        $g->add_pie_label(qw( May Jun Jul Aug Sep Oct ) );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=v&chs=200x100&chd=t:100,80,60,30,30,30,10&chco=00ff00,0000ff' => sub {
        my $g = Google::Chart->create(
            Venn => (
                size => '200x100',
            )
        );
        $g->add_dataset(
            data => [ qw(100 80 60 30 30 30 10) ]
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?chs=200x125&cht=gom&chd=t:70&chco=ffffff,ff0000' => sub {
        my $g = Google::Chart->create(
            GoogleOMeter => (
                size => '200x125',
                colors => [ 'ffffff', 'ff0000' ],
            )
        );
        $g->add_dataset(
            data => [ 70 ]
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=lc&chd=s:99,cefhjkqwrlgYcfgc,QSSVXXdkfZUMRTUQ,HJJMOOUbVPKDHKLH,AA&chco=000000,000000,000000,000000,000000&chls=1,1,0|1,1,0|1,1,0|1,4,0&chs=200x125&chxt=x,y&chxl=0:|Sep|Oct|Nov|Dec|1:||50|100&chg=25,25&chm=b,76A4FB,0,1,0|b,224499,1,2,0|b,FF0000,2,3,0|b,80C65A,3,4,0' => sub {
        my $g = Google::Chart->create(
            Line => (
                size => '200x125',
                encoding_class => 'Simple',
                grid_x_step_size => 25,
                grid_y_step_size => 25,
            )
        );
        $g->add_axis(
            location => 'y',
            labels => [ undef, 50, 100 ]
        );
        $g->add_axis(
            location => 'x',
            labels => [ qw( Sep Oct Nov Dec ) ],
        );
        $g->add_dataset(
            line_thickness => 1,
            line_segment_length => 1,
            blank_segment_length => 0,
            color => '000000',
            data => [ qw( 61 61 ) ],
        );
        $g->add_dataset(
            line_thickness => 1,
            line_segment_length => 1,
            blank_segment_length => 0,
            color => '000000',
            data => [ qw( 28 30 31 33 35 36 42 48 43 37 32 24 28 31 32 28 ) ],
        );
        $g->add_dataset(
            line_thickness => 1,
            line_segment_length => 1,
            blank_segment_length => 0,
            color => '000000',
            data => [ qw( 16 18 18 21 23 23 29 36 31 25 20 12 17 19 20 16 ) ],
        );
        $g->add_dataset(
            line_thickness => 1,
            line_segment_length => 4,
            blank_segment_length => 0,
            color => '000000',
            data => [ qw( 7 9 9 12 14 14 20 27 21 15 10 3 7 10 11 7 ) ],
        );
        $g->add_dataset(
            color => '000000',
            data => [ qw( 0 0 ) ]
        );
        $g->add_range_fill(
            color => '76A4FB',
            start_index => 0,
            end_index => 1,
        );
        $g->add_range_fill(
            color => '224499',
            start_index => 1,
            end_index => 2,
        );
        $g->add_range_fill(
            color => 'FF0000',
            start_index => 2,
            end_index => 3,
        );
        $g->add_range_fill(
            color => '80C65A',
            start_index => 3,
            end_index => 4,
        );

        return $g;
    },
    'http://chart.apis.google.com/chart?cht=lc&chd=s:cefhjkqwrlgYcfgc,QSSVXXdkfZUMRTUQ,HJJMOOUbVPKDHKLH&chls=1,1,0|1,1,0|1,1,0|1,4,0&chxt=x,y&chxl=0:|Sep|Oct|Nov|Dec|1:||50|100&chs=200x125&chm=b,224499,0,1,0|b,FF0000,1,2,0|b,80C65A,2,3,0' => sub {

        my $g = Google::Chart->create(
            Line => (
                size => '200x125',
                encoding_class => 'Simple',
            )
        );
        $g->add_axis(
            location => 'x',
            labels => [ qw(Sep Oct Nov Dec) ],
        );
        $g->add_axis(
            location => 'y',
            labels => [ undef, 50, 100 ]
        );
        $g->add_dataset(
            line_thickness => 1,
            line_segment_length => 1,
            blank_segment_length => 0,
            data => [ qw( 28 30 31 33 35 36 42 48 43 37 32 24 28 31 32 28 ) ],
        );
        $g->add_dataset(
            line_thickness => 1,
            line_segment_length => 1,
            blank_segment_length => 0,
            data => [ qw( 16 18 18 21 23 23 29 36 31 25 20 12 17 19 20 16 ) ],
        );
        $g->add_dataset(
            line_thickness => 1,
            line_segment_length => 1,
            blank_segment_length => 0,
            data => [ qw(  7 9 9 12 14 14 20 27 21 15 10 3 7 10 11 7 ) ],
        );
        $g->add_range_fill(
            type => 'b',
            color => '224499',
            start_index => 0,
            end_index => 1,
        );
        $g->add_range_fill(
            type => 'b',
            color => 'FF0000',
            start_index => 1,
            end_index => 2,
        );
        $g->add_range_fill(
            type => 'b',
            color => '80C65A',
            start_index => 2,
            end_index => 3,
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=lc&chs=200x125&chd=s:ATSTaVd21981uocA&chco=224499&chxt=x,y&chxl=0:|Sep|Oct|Nov|Dec|1:||50|100&chm=B,76A4FB,0,0,0' => sub {
        my $g = Google::Chart->create(
            Line => (
                size => '200x125',
                encoding_class => 'Simple',
            )
        );
        $g->add_axis(
            location => 'x',
            labels => [ qw(Sep Oct Nov Dec) ],
        );
        $g->add_axis(
            location => 'y',
            labels => [ undef, 50, 100 ]
        );
        $g->add_dataset(
            color => '224499',
            data => [ qw(0 19 18 19 26 21 29 54 53 61 60 53 46 40 28 0 ) ],
        );
        $g->add_range_fill(
            type => 'B',
            color => '76A4FB',
            start_index => 0,
            end_index => 0
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=lc&chd=s:pqokeYONOMEBAKPOQVTXZdecaZcglprqxuux393ztpoonkeggjp&chco=FF0000&chls=4.0,3.0,0.0&chs=200x125&chxt=x,y&chxl=0:|Jun|July|Aug|1:||20|30|40|50&chf=bg,s,efefef' => sub {
        my $g = Google::Chart->create(
            Line => (
                size => '200x125',
                encoding_class => 'Simple',
            )
        );
        $g->add_axis(
            location => 'x',
            labels => [ qw(Jun July Aug) ],
        );
        $g->add_axis(
            location => 'y',
            labels => [ undef, 20, 30, 40, 50 ]
        );
        $g->add_dataset(
            color => 'FF0000',
            line_thickness => 4,
            line_segment_length => 3,
            blank_segment_length => 0,
            data => [ qw(41 42 40 36 30 24 14 13 14 12 4 1 0 10 15 14 16 21 19 23 25 29 30 28 26 25 28 32 37 41 43 42 49 46 46 49 55 61 55 51 45 41 40 40 39 36 30 32 32 35 41 ) ]
        );
        $g->add_solid_fill(
            type => 'bg',
            color => 'efefef',
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=s&chd=s:pqokeYONOMEPOQVTXZdeca,Zcglprqxuuxztpoonkeggjp&chco=FF0000&chls=4.0,3.0,0.0&chs=200x125&chxt=x,y&chxl=0:|Jun|July|Aug|1:||20|30|40|50&chf=bg,s,efefef|c,s,000000' => sub {
        my $g = Google::Chart->create(
            ScatterPlot => (
                size => '200x125',
                encoding_class => 'Simple',
            )
        );
        $g->add_axis(
            location => 'x',
            labels => [ qw(Jun July Aug) ],
        );
        $g->add_axis(
            location => 'y',
            labels => [ undef, 20, 30, 40, 50 ]
        );
        $g->add_dataset(
            color => 'FF0000',
            data => [ qw( 41 42 40 36 30 24 14 13 14 12 4 15 14 16 21 19 23 25 29 30 28 26 ) ]
        );
        $g->add_dataset(
            data => [ qw( 25 28 32 37 41 43 42 49 46 46 49 51 45 41 40 40 39 36 30 32 32 35 41  ) ]
        );
        $g->add_solid_fill(
            type => 'bg',
            color => 'efefef',
        );
        $g->add_solid_fill(
            type => 'c',
            color => '000000',
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=s&chd=s:pqokeYONOMEPOQVTXZdeca,Zcglprqxuuxztpoonkeggjp&chco=FF0000&chls=4.0,3.0,0.0&chs=200x125&chxt=x,y&chxl=0:|Jun|July|Aug|1:||20|30|40|50&chf=bg,s,efefef20|c,s,00000080' => sub {
        my $g = Google::Chart->create(
            ScatterPlot => (
                size => '200x125',
                encoding_class => 'Simple',
            )
        );
        $g->add_axis(
            location => 'x',
            labels => [ qw(Jun July Aug) ],
        );
        $g->add_axis(
            location => 'y',
            labels => [ undef, 20, 30, 40, 50 ]
        );
        $g->add_dataset(
            color => 'FF0000',
            data => [ qw( 41 42 40 36 30 24 14 13 14 12 4 15 14 16 21 19 23 25 29 30 28 26 ) ]
        );
        $g->add_dataset(
            data => [ qw( 25 28 32 37 41 43 42 49 46 46 49 51 45 41 40 40 39 36 30 32 32 35 41  ) ]
        );
        $g->add_solid_fill(
            type => 'bg',
            color => 'efefef20',
        );
        $g->add_solid_fill(
            type => 'c',
            color => '00000080',
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=s&chd=s:pqokeYONOMEPOQVTXZdeca,Zcglprqxuuxztpoonkeggjp&chls=4.0,3.0,0.0&chs=200x125&chxt=x,y&chxl=0:|Jun|July|Aug|1:||20|30|40|50&chf=a,s,efefeff0' => sub {
        my $g = Google::Chart->create(
            ScatterPlot => (
                size => '200x125',
                encoding_class => 'Simple',
            )
        );
        $g->add_axis(
            location => 'x',
            labels => [ qw(Jun July Aug) ],
        );
        $g->add_axis(
            location => 'y',
            labels => [ undef, 20, 30, 40, 50 ]
        );
        $g->add_dataset(
            data => [ qw( 41 42 40 36 30 24 14 13 14 12 4 15 14 16 21 19 23 25 29 30 28 26 ) ]
        );
        $g->add_dataset(
            data => [ qw( 25 28 32 37 41 43 42 49 46 46 49 51 45 41 40 40 39 36 30 32 32 35 41  ) ]
        );
        $g->add_solid_fill(
            type => 'a',
            color => 'efefeff0',
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=lc&chd=s:pqokeYONOMEBAKPOQVTXZdecaZcglprqxuux393ztpoonkeggjp&chco=676767&chls=4.0,3.0,0.0&chs=200x125&chxt=x,y&chxl=0:|1|2|3|4|5|1:|0|50|100&chf=c,lg,0,76A4FB,1,ffffff,0|bg,s,EFEFEF' => sub {
        my $g = Google::Chart->create(
            Line => (
                size => '200x125',
                encoding_class => 'Simple',
            )
        );
        $g->add_axis(
            location => 'x',
            labels => [ qw(1 2 3 4 5) ],
        );
        $g->add_axis(
            location => 'y',
            labels => [ qw( 0 50 100) ]
        );
        $g->add_linear_gradient_fill(
            type => 'c',
            angle => 0,
            colors => [
                '76A4FB' => 1,
                'ffffff' => 0,
            ]
        );
        $g->add_solid_fill(
            type => 'bg',
            color => 'EFEFEF',
        );
        $g->add_dataset(
            color => '676767',
            line_thickness => 4,
            line_segment_length => 3,
            blank_segment_length => 0,
            data => [ qw(41 42 40 36 30 24 14 13 14 12 4 1 0 10 15 14 16 21 19 23 25 29 30 28 26 25 28 32 37 41 43 42 49 46 46 49 55 61 55 51 45 41 40 40 39 36 30 32 32 35 41 ) ]
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=lc&chd=s:pqokeYONOMEBAKPOQVTXZdecaZcglprqxuux393ztpoonkeggjp&chco=676767&chls=4.0,3.0,0.0&chxt=x,y&chxl=0:|1|2|3|4|5|1:|0|50|100&chs=200x125&chf=c,lg,45,ffffff,0,76A4FB,0.75|bg,s,EFEFEF' => sub {
        my $g = Google::Chart->create(
            Line => (
                encoding_class => 'Simple',
                size => '200x125',
            )
        );
        $g->add_axis(
            location => 'x',
            labels => [ qw(1 2 3 4 5) ],
        );
        $g->add_axis(
            location => 'y',
            labels => [ qw( 0 50 100) ]
        );
        $g->add_linear_gradient_fill(
            type => 'c',
            angle => 45,
            colors => [
                'ffffff' => 0,
                '76A4FB' => 0.75,
            ]
        );
        $g->add_solid_fill(
            type => 'bg',
            color => 'EFEFEF',
        );
        $g->add_dataset(
            color => '676767',
            line_thickness => 4,
            line_segment_length => 3,
            blank_segment_length => 0,
            data => [ qw(41 42 40 36 30 24 14 13 14 12 4 1 0 10 15 14 16 21 19 23 25 29 30 28 26 25 28 32 37 41 43 42 49 46 46 49 55 61 55 51 45 41 40 40 39 36 30 32 32 35 41 ) ]
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=lc&chd=s:pqokeYONOMEBAKPOQVTXZdecaZcglprqxuux393ztpoonkeggjp&chco=676767&chls=4.0,3.0,0.0&chs=200x125&chxt=x,y&chxl=0:|1|2|3|4|5|1:|0|50|100&chf=c,lg,90,76A4FB,0.5,ffffff,0|bg,s,EFEFEF' => sub {
        my $g = Google::Chart->create(
            Line => (
                encoding_class => 'Simple',
                size => '200x125',
            )
        );
        $g->add_axis(
            location => 'x',
            labels => [ qw(1 2 3 4 5) ],
        );
        $g->add_axis(
            location => 'y',
            labels => [ qw( 0 50 100) ]
        );
        $g->add_linear_gradient_fill(
            type => 'c',
            angle => 90,
            colors => [
                '76A4FB' => 0.5,
                'ffffff' => 0,
            ]
        );
        $g->add_solid_fill(
            type => 'bg',
            color => 'EFEFEF',
        );
        $g->add_dataset(
            color => '676767',
            line_thickness => 4,
            line_segment_length => 3,
            blank_segment_length => 0,
            data => [ qw(41 42 40 36 30 24 14 13 14 12 4 1 0 10 15 14 16 21 19 23 25 29 30 28 26 25 28 32 37 41 43 42 49 46 46 49 55 61 55 51 45 41 40 40 39 36 30 32 32 35 41 ) ]
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=lc&chd=s:UVVUVVUUUVVUSSVVVXXYadfhjlllllllmmliigdbbZZXVVUUUTU&chco=0000FF&chls=2.0,1.0,0.0&chxt=x,y&chxl=0:|Jan|Feb|Mar|Jun|Jul|Aug|1:|0|25|50|75|100&chs=200x125&chg=100.0,25.0&chf=c,ls,0,CCCCCC,0.2,ffffff,0.2' => sub {
        my $g = Google::Chart->create(
            Line => (
                size => '200x125',
                encoding_class => 'Simple',
                grid_x_step_size => 100,
                grid_y_step_size => 25,
            )
        );
        $g->add_axis(
            location => 'y',
            labels => [ qw(0 25 50 75 100) ],
        );
        $g->add_axis(
            location => 'x',
            labels => [ qw(Jan Feb Mar Jun Jul Aug) ]
        );
        $g->add_dataset(
            color => '0000FF',
            line_thickness => 2,
            line_segment_length => 1,
            blank_segment_length => 0,
            data => [ qw( 20 21 21 20 21 21 20 20 20 21 21 20 18 18 21 21 21 23 23 24 26 29 31 33 35 37 37 37 37 37 37 37 38 38 37 34 34 32 29 27 27 25 25 23 21 21 20 20 20 19 20 ) ],
        );
        $g->add_linear_stripe(
            type => 'c',
            angle => 0,
            colors => [
                CCCCCC => 0.2,
                ffffff => 0.2
            ],
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=lc&chd=s:UVVUVVUUUVVUSSVVVXXYadfhjlllllllmmliigdbbZZXVVUUUTU&chco=0000FF&chls=2.0,1.0,0.0&chs=200x125&chxt=x,y&chxl=0:|Jan|Feb|Mar|Jun|Jul|Aug|1:|0|25|50|75|100&chg=100.0,25.0&chf=c,ls,90,999999,0.25,CCCCCC,0.25,FFFFFF,0.25' => sub {
        my $g = Google::Chart->create(
            Line => (
                size => '200x125',
                encoding_class => 'Simple',
                grid_x_step_size => 100,
                grid_y_step_size => 25,
            )
        );
        $g->add_axis(
            location => 'y',
            labels => [ qw(0 25 50 75 100) ],
        );
        $g->add_axis(
            location => 'x',
            labels => [ qw(Jan Feb Mar Jun Jul Aug) ]
        );
        $g->add_dataset(
            color => '0000FF',
            line_thickness => 2,
            line_segment_length => 1,
            blank_segment_length => 0,
            data => [ qw( 20 21 21 20 21 21 20 20 20 21 21 20 18 18 21 21 21 23 23 24 26 29 31 33 35 37 37 37 37 37 37 37 38 38 37 34 34 32 29 27 27 25 25 23 21 21 20 20 20 19 20 ) ],
        );
        $g->add_linear_stripe(
            type => 'c',
            angle => 90,
            colors => [
                999999 => 0.25,
                CCCCCC => 0.25,
                ffffff => 0.25
            ],
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=bvs&chd=s:YUVmw1&chco=0000FF&chs=180x150&chtt=Site' => sub {
        my $g = Google::Chart->create(
            Bar => (
                orientation => 'vertical',
                stacked => 1,
                size => '180x150',
                encoding_class => 'Simple',
                title => 'Site',
            )
        );
        $g->add_dataset(
            color => '0000FF',
            data => [ qw( 24 20 21 38 48 53 ) ],
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?&cht=ls&chd=t:0,30,60,70,90,95,100|20,30,40,50,60,70,80|10,30,40,45,52&chco=ff0000,00ff00,0000ff&chs=250x150&chdl=NASDAQ|FTSE100|DOW' => sub {
        my $g = Google::Chart->create(
            SparkLine => (
                size => '250x150',
                
            )
        );
        $g->add_dataset(
            color => 'ff0000',
            legend => 'NASDAQ',
            data => [ 0,30,60,70,90,95,100 ],
        );
        $g->add_dataset(
            color => '00ff00',
            legend => 'FTSE100',
            data => [ 20,30,40,50,60,70,80 ],
        );
        $g->add_dataset(
            color => '0000ff',
            legend => 'DOW',
            data => [ 10,30,40,45,52 ]
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=v&chs=200x100&chd=t:100,20,20,20,20,0,0&chdl=First|Second|Third&chco=ff0000,00ff00,0000ff' => sub {
        my $g = Google::Chart->create(
            Venn => (
                size => '200x100',
                legend => [ 'First', 'Second', 'Third' ],
                colors => [ 'ff0000', '00ff00', '0000ff' ],
            )
        );
        $g->add_dataset(
            data => [ 100,20,20,20,20,0,0 ]
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=v&chs=200x100&chd=t:100,20,20,20,20,0,0&chdl=First|Second|Third&chco=ff0000,00ff00,0000ff&chdlp=l' => sub {
        my $g = Google::Chart->create(
            Venn => (
                size => '200x100',
                legend_position => 'l',
                legend => [ 'First', 'Second', 'Third' ],
                colors => [ 'ff0000', '00ff00', '0000ff' ],
            )
        );
        $g->add_dataset(
            data => [ 100,20,20,20,20,0,0 ]
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=p3&chs=220x100&chd=s:Hellob&chl=May|Jun|Jul|Aug|Sep|Oct' => sub {
        my $g = Google::Chart->create(
            Pie => (
                size => '220x100',
                pie_type => '3d',
            )
        );
        $g->add_dataset(
            data => [ qw(7 30 37 37 40 27) ],
        );
        $g->add_pie_label( qw(May Jun Jul Aug Sep Oct) );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=p3&chs=220x100&chd=s:Hellob&chl=May|June|July|August|September|October' => sub {
        my $g = Google::Chart->create(
            Pie => (
                size => '220x100',
                pie_type => '3d',
            )
        );
        $g->add_dataset(
            data => [ qw(7 30 37 37 40 27) ],
        );
        $g->add_pie_label( qw(May June July August September October) );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=p3&chs=280x100&chd=s:Hellob&chl=May|June|July|August|September|October' => sub {
        my $g = Google::Chart->create(
            Pie => (
                size => '280x100',
                pie_type => '3d',
            )
        );
        $g->add_dataset(
            data => [ qw(7 30 37 37 40 27) ],
        );
        $g->add_pie_label( qw(May June July August September October) );
        return $g;
    },
    'http://chart.apis.google.com/chart?chs=225x125&cht=gom&chd=t:70&chl=Hello' => sub {
        my $g = Google::Chart->create(
            GoogleOMeter => (
                size => '225x125',
                label => 'Hello',
            )
        );
        $g->add_dataset(
            data => [ 70 ]
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?chxt=x,y,r,x,t&cht=lc&chd=s:cEAELFJHHHKUju9uuXUc&chco=76A4FB&chls=2.0&chs=200x125' => sub {
        my $g = Google::Chart->create(
            Line => (
                size => '200x125',
                encoding_class => 'Simple',
            )
        );
        $g->add_axis(
            location => 'x',
        );
        $g->add_axis(
            location => 'y',
        );
        $g->add_axis(
            location => 'r',
        );
        $g->add_axis(
            location => 'x',
        );
        $g->add_axis(
            location => 't',
        );
        $g->add_dataset(
            color => '76A4FB',
            line_thickness => 2,
            data => [ qw( 4 0 4 11 5 9 7 7 7 10 20 35 46 61 46 46 23 20 28 ) ]
        );
        return $g;
     },
    'http://chart.apis.google.com/chart?chxt=x,y,r,x,t&cht=bvs&chd=s:cLJHc&chco=76A4FB&chls=2.0&chs=200x125' => sub {
        my $g = Google::Chart->create(
            Bar => (
                orientation => 'vertical',
                stacked => 1,
                size => '200x125',
                encoding_class => 'Simple',
            )
        );
        $g->add_axis(
            location => 'x',
        );
        $g->add_axis(
            location => 'y',
        );
        $g->add_axis(
            location => 'r',
        );
        $g->add_axis(
            location => 'x',
        );
        $g->add_axis(
            location => 't',
        );
        $g->add_dataset(
            color => '76A4FB',
            data => [ qw( 28 11 9 7 28 ) ]
        );
        return $g;
     },
    'http://chart.apis.google.com/chart?chxt=x,y,r,x,t&cht=bhs&chd=s:cLJHc&chco=76A4FB&chls=2.0&chs=200x200' => sub {
        my $g = Google::Chart->create(
            Bar => (
                orientation => 'horizontal',
                stacked => 1,
                size => '200x200',
                encoding_class => 'Simple',
            )
        );
        $g->add_axis(
            location => 'x',
        );
        $g->add_axis(
            location => 'y',
        );
        $g->add_axis(
            location => 'r',
        );
        $g->add_axis(
            location => 'x',
        );
        $g->add_axis(
            location => 't',
        );
        $g->add_dataset(
            color => '76A4FB',
            data => [ qw( 28 11 9 7 28 ) ]
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?chxt=x,y,r,x&chxl=0:|Jan|July|Jan|July|Jan|1:|0|100|2:|A|B|C|3:|2005|2006|2007&cht=lc&chd=s:cEAELFJHHHKUju9uuXUc&chco=76A4FB&chls=2.0&chs=200x125' => sub {
        my $g = Google::Chart->create(
            Line => (
                size => '200x125',
                encoding_class => 'Simple',
            )
        );
        $g->add_axis(
            location => 'x',
            labels => [ qw(Jan July Jan July Jan) ],
        );
        $g->add_axis(
            location => 'y',
            labels => [ qw( 0 100 ) ],
        );
        $g->add_axis(
            location => 'r',
            labels => [ qw(A B C) ],
        );
        $g->add_axis(
            location => 'x',
            labels => [ qw(2005 2006 2007) ],
        );
        $g->add_dataset(
            line_thickness => 2,
            color => '76A4FB',
            data => [ qw( 4 0 4 11 5 9 7 7 7 10 20 35 46 61 46 46 23 20 28 ) ]
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?chxt=x,y,r,x&chxl=0:|Jan|July|Jan|July|Jan|1:|0|100|2:|A|B|C|3:|2005|2005|2006|2006|2007&cht=bvs&chd=s:c9uDc&chco=76A4FB&chls=2.0&chs=200x125' => sub { 
        my $g = Google::Chart->create(
            Bar => (
                orientation => 'vertical',
                stacked => 1,
                size => '200x125',
                encoding_class => 'Simple',
            )
        );
        $g->add_axis(
            location => 'x',
            labels => [ qw(Jan July Jan July Jan) ],
        );
        $g->add_axis(
            location => 'y',
            labels => [ qw( 0 100 ) ],
        );
        $g->add_axis(
            location => 'r',
            labels => [ qw(A B C) ],
        );
        $g->add_axis(
            location => 'x',
            labels => [ qw(2005 2005 2006 2006 2007) ],
        );
        $g->add_dataset(
            color => '76A4FB',
            line_thickness => 2,
            data => [ qw(28 61 46 3 28) ],
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?chxt=x,y,r,x&chxl=0:|Jan|July|Jan|July|Jan|2:|A|B|C|3:|2005|2006|2007&cht=lc&chd=s:cEAELFJHHHKUju9uuXUc&chco=76A4FB&chls=2.0&chs=200x125' => sub {
        my $g = Google::Chart->create(
            Line => (
                size => '200x125',
                encoding_class => 'Simple',
            )
        );
        $g->add_axis(
            location => 'x',
            labels => [ qw(Jan July Jan July Jan) ],
        );
        $g->add_axis(
            location => 'y',
        );
        $g->add_axis(
            location => 'r',
            labels => [ qw(A B C) ],
        );
        $g->add_axis(
            location => 'x',
            labels => [ qw(2005 2006 2007) ],
        );
        $g->add_dataset(
            line_thickness => 2,
            color => '76A4FB',
            data => [ qw( 4 0 4 11 5 9 7 7 7 10 20 35 46 61 46 46 23 20 28 ) ]
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?chxt=x,y,r,x&chxl=0:|Jan|July|Jan|July|Jan|2:|A|B|C|3:|2005|2005|2006|2006|2007&cht=bvs&chd=s:c9uDc&chco=76A4FB&chls=2.0&chs=200x125' => sub { 
        my $g = Google::Chart->create(
            Bar => (
                orientation => 'vertical',
                stacked => 1,
                size => '200x125',
                encoding_class => 'Simple',
            )
        );
        $g->add_axis(
            location => 'x',
            labels => [ qw(Jan July Jan July Jan) ],
        );
        $g->add_axis(
            location => 'y',
        );
        $g->add_axis(
            location => 'r',
            labels => [ qw(A B C) ],
        );
        $g->add_axis(
            location => 'x',
            labels => [ qw(2005 2005 2006 2006 2007) ],
        );
        $g->add_dataset(
            color => '76A4FB',
            line_thickness => 2,
            data => [ qw(28 61 46 3 28) ],
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?chxt=x,y,r&chxr=2,0,4&chxl=1:|min|average|max&chxp=1,10,35,75|2,0,1,2,4&cht=lc&chd=s:cEAELFJHHHKUju9uuXUc&chco=76A4FB&chls=2.0&chs=200x125' => sub { },
    'http://chart.apis.google.com/chart?chxt=x,y,r,x&chxr=2,0,4|3,0,4&chxl=1:|min|average|max&chxp=0,10,35,75|1,10,35,75|2,0,1,2,4|3,0,1,2,4&cht=bvs&chd=s:c9uDc&chco=76A4FB&chls=2.0&chs=200x125' => sub { },
    'http://chart.apis.google.com/chart?chxt=x,y,r&chxr=0,100,500|1,0,200|2,1000,0&cht=lc&chd=s:cEAELFJHHHKUju9uuXUc&chco=76A4FB&chls=2.0&chs=200x125' => sub { },
    'http://chart.apis.google.com/chart?chxt=x,y,r&chxr=0,100,500|1,0,200|2,1000,0&cht=bvs&chd=s:c9uDc&chco=76A4FB&chls=2.0&chs=200x125' => sub { },
    'http://chart.apis.google.com/chart?chxt=x&chxl=0:|200|300|400&chxp=0,200,300,400&chxr=0,100,500&cht=lc&chd=s:cEAELFJHUc&chco=76A4FB&chls=2.0&chs=200x125' => sub { },
    'http://chart.apis.google.com/chart?chxt=x&chxl=0:|200|300|400&chxp=0,200,300,400&chxr=0,100,500&cht=bvs&chd=s:c9uDc&chco=76A4FB&chls=2.0&chs=200x125' => sub { },
    'http://chart.apis.google.com/chart?chxt=x,y,r,x&chxr=2,0,4&chxl=3:|Jan|Feb|Mar|1:|min|average|max&chxp=1,10,35,75&cht=lc&chd=s:cEAELFJHHHKUju9uuXUc&chco=76A4FB&chls=2.0&chs=220x125&chxs=3,0000dd,12' => sub { },
    'http://chart.apis.google.com/chart?chxt=x,y,r,x&chxr=2,0,4&chxl=3:|Jan|Feb|Mar|1:|min|average|max&chxp=1,10,35,75&cht=lc&chd=s:cEAELFJHHHKUju9uuXUc&chco=76A4FB&chls=2.0&chs=220x125&chxs=3,0000dd,12' => sub { },
    'http://chart.apis.google.com/chart?chxt=x,x&chxl=1:||Feb|Mar||0:|1st|15th|1st|15th|1st&cht=lc&chd=s:cEAELFJHHHKUju9uuXUc&chco=76A4FB&chls=2.0&chs=200x125&chxs=0,0000dd,10|1,0000dd,12,0' => sub { },
    'http://chart.apis.google.com/chart?chxt=x,x&chxl=1:||Feb|Mar||0:|1st|15th|1st|15th|1st&cht=lc&chd=s:cEAELFJHHHKUju9uuXUc&chco=76A4FB&chls=2.0&chs=200x125&chxs=0,0000dd,10|1,0000dd,12,0' => sub { },
    'http://chart.apis.google.com/chart?cht=bhg&chs=200x125&chd=s:elg,ors&chbh=10&chco=cc0000,00aa00' => sub { },
    'http://chart.apis.google.com/chart?cht=bhg&chs=200x125&chd=s:elg,ors&chbh=10,5,15&chco=cc0000,00aa00' => sub { },
    'http://chart.apis.google.com/chart?cht=bhg&chs=200x125&chd=s:elg,ors&chbh=10,8&chco=cc0000,00aa00' => sub { },
    'http://chart.apis.google.com/chart?cht=bhg&chs=200x125&chd=s:elg,ors&chbh=10,15&chco=cc0000,00aa00' => sub { },
    'http://chart.apis.google.com/chart?cht=bvg&chs=200x125&chd=t:20,35,50,10,95&chco=cc0000&chp=.5' => sub {
        my $g = Google::Chart->create(
            Bar => (
                orientation => 'vertical',
                bar_zero => 0.5,
                size => '200x125',
            )
        );
        $g->add_dataset(
            color => 'cc0000',
            data => [ qw(20 35 50 10 95) ]
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=bvg&chs=200x125&chco=cc0000,00aa00&chd=t:30,-60,50,120,80&chds=-80,140' => sub {
        my $g = Google::Chart->create(
            Bar => (
                orientation => 'vertical',
                size => '200x125',
            )
        );
        $g->add_dataset(
            color => 'cc0000',
            data => [ 30, -60, 50, 120, 80 ],
            min_value => -80,
            max_value => 140,
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=lc&chd=s:93zyvneTTOMJMLIJFHEAECFJGHDBFCFIERcgnpy45879,IJKNUWUWYdnswz047977315533zy1246872tnkgcaZQONHCECAAAAEII&chls=3,6,3|1,1,0&chs=200x125' => sub {
        my $g = Google::Chart->create(
            Line => (
                size => '200x125',
                encoding_class => 'Simple',
            )
        );

        $g->add_dataset(
            line_thickness => 3,
            line_segment_length => 6,
            blank_segment_length => 3,
            data => [ qw( 61 55 51 50 47 39 30 19 19 14 12 9 12 11 8 9 5 7 4 0 4 2 5 9 6 7 3 1 5 2 5 8 4 17 28 32 39 41 50 56 57 60 59 61 ) ],
        );
        $g->add_dataset(
            line_thickness => 1,
            line_segment_length => 1,
            blank_segment_length => 0,
            data => [ qw( 8 9 10 13 20 22 20 22 24 29 39 44 48 51 52 56 59 61 59 59 55 53 57 57 55 55 51 50 53 54 56 58 60 59 54 45 39 36 32 28 26 25 16 14 13 7 2 4 2 0 0 0 0 4 8 8 ) ]
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=bvg&chbh=5,2&chm=B,C6D9FD,0,0,0|D,4D89F9,0,0,5,1&chbh=20&chs=200x150&chd=s:1XQbnf4&chco=76A4FB' => sub {
        my $g = Google::Chart->create(
            Bar => (
                orientation => 'vertical',
                bar_width => 5,
                bar_space => 2,
                size => '200x150',
            )
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=ls&chs=200x125&chd=s:foeZ9Gat,lkjtf3asv&chm=D,C6D9FD,1,0,8|D,4D89F9,0,0,4' => sub {
        my $g = Google::Chart->create(
            SparkLine => (
                size => '200x125',
                encoding_class => 'Simple'
            )
        );
        $g->add_dataset(
            data => [ qw( 31 40 30 25 61 6 26 45 ) ],
            
        );
        $g->add_dataset(
            data => [ qw( 37 36 35 45 31 55 26 44 47 ) ],
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=lc&chd=s:cEAELFJHHHKUju9uuXUc&chco=76A4FB&chls=2.0,0.0,0.0&chxt=x,y&chxl=0:|0|1|2|3|4|5|1:|0|50|100&chs=200x125&chg=20,50' => sub {
        my $g = Google::Chart->create(
            Line => (
                size => '200x125',
                encoding_class => 'Simple',
                grid_x_step_size => 20,
                grid_y_step_size => 50,
            )
        );
        $g->add_axis(
            location => 'x',
            labels => [ qw(0 1 2 3 4 5) ]
        );
        $g->add_axis(
            location => 'y',
            labels => [ qw(0 50 100) ]
        );
        $g->add_dataset(
            color => '76A4FB',
            data => [ qw(28 4 0 4 11 5 9 7 7 7 10 20 35 46 61 46 46 23 20 28 ) ],
            line_thickness => 2,
            line_segment_length => 0,
            blank_segment_length => 0,
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=lc&chd=s:cEAELFJHHHKUju9uuXUc&chco=76A4FB&chls=2.0,0.0,0.0&chxt=x,y&chxl=0:|0|1|2|3|4|5|1:|0|50|100&chs=200x125&chg=20,50,1,5' => sub {
        my $g = Google::Chart->create(
            Line => (
                size => '200x125',
                encoding_class => 'Simple',
                grid_x_step_size => 20,
                grid_y_step_size => 50,
                grid_line_length => 1,
                grid_blank_length => 5,
            )
        );
        $g->add_axis(
            location => 'x',
            labels => [ qw(0 1 2 3 4 5) ]
        );
        $g->add_axis(
            location => 'y',
            labels => [ qw(0 50 100) ]
        );
        $g->add_dataset(
            color => '76A4FB',
            data => [ qw(28 4 0 4 11 5 9 7 7 7 10 20 35 46 61 46 46 23 20 28 ) ],
            line_thickness => 2,
            line_segment_length => 0,
            blank_segment_length => 0,
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=lc&chd=s:cEAELFJHHHKUju9uuXUc&chco=76A4FB&chls=2.0,0.0,0.0&chs=200x125&chg=20,50,1,0&chxt=x,y&chxl=0:|0|1|2|3|4|5|1:|0|50|100' => sub {
        my $g = Google::Chart->create(
            Line => (
                size => '200x125',
                encoding_class => 'Simple',
                grid_x_step_size => 20,
                grid_y_step_size => 50,
                grid_line_length => 1,
                grid_blank_length => 0,
            )
        );
        $g->add_axis(
            location => 'x',
            labels => [ qw(0 1 2 3 4 5) ]
        );
        $g->add_axis(
            location => 'y',
            labels => [ qw(0 50 100) ]
        );
        $g->add_dataset(
            color => '76A4FB',
            data => [ qw(28 4 0 4 11 5 9 7 7 7 10 20 35 46 61 46 46 23 20 28 ) ],
            line_thickness => 2,
            line_segment_length => 0,
            blank_segment_length => 0,
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=lc&chd=s:9gounjqGJD&chco=008000&chls=2.0,4.0,1.0&chs=200x125&chxt=x&chxl=0:||c|d|a|o|x|v|V|x|&chm=a,990066,0,3.0,9.0|c,FF0000,0,1.0,20.0|d,80C65A,0,2.0,20.0|o,FF9900,0,4.0,20.0|s,3399CC,0,5.0,10.0|v,BBCCED,0,6.0,1.0|V,3399CC,0,7.0,1.0|x,FFCC33,0,8.0,20.0|h,000000,0,0.30,0.5' => sub {
        my $g = Google::Chart->create(
            Line => (
                size => '200x125',
                encoding_class => 'Simple',
            )
        );
        $g->add_axis(
            location => 'x',
            labels => [ undef, qw(c d a o x v V x), undef]
        );
        $g->add_dataset(
            color => '008000',
            data => [ qw(61 32 40 46 39 35 42 6 9 3 ) ],
            line_thickness => 2.0,
            line_segment_length => 4.0,
            blank_segment_length => 1.0,
        );
        $g->add_marker(
            type => 'a',
            color => '990066',
            point => 3,
            size => 9
        );
        $g->add_marker(
            type => 'c',
            color => 'FF0000',
            point => 1,
            size => 20
        );
        $g->add_marker(
            type => 'd',
            color => '80C65A',
            point => 2,
            size => 20
        );
        $g->add_marker(
            type => 'o',
            color => 'FF9900',
            point => 4,
            size => 20
        );
        $g->add_marker(
            type => 's',
            color => '3399CC',
            point => 5,
            size => 10
        );
        $g->add_marker(
            type => 'v',
            color => 'BBCCED',
            point => 6,
            size => 1,
        );
        $g->add_marker(
            type => 'V',
            color => '3399CC',
            point => 7,
            size => 1,
        );
        $g->add_marker(
            type => 'x',
            color => 'FFCC33',
            point => 8,
            size => 20
        );
        $g->add_marker(
            type => 'h',
            color => '000000',
            point => 0.3,
            size => 0.5
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=s&chd=s:984sttvuvkQIBLKNCAIipr3z9,DEJPgq0uov17_zwopQOD&chs=200x125&chxt=x,y&chxl=0:||1|2|3|4|5|1:||50|100&chg=20.0,25.0&chm=s,FF0000,1,1.0,10.0' => sub {
        my $g = Google::Chart->create(
            ScatterPlot => (
                size => '200x125',
                encoding_class => 'Simple',
                grid_x_step_size  => 20,
                grid_y_step_size  => 25
            )
        );
        $g->add_axis(
            location => 'x',
            labels => [ undef, 1, 2, 3, 4, 5 ],
        );
        $g->add_axis(
            location => 'y',
            labels => [ undef, 50, 100 ]
        );
        $g->add_dataset(
            data => [ qw( 61 60 56 44 45 45 47 46 47 36 16 8 1 11 10 13 2 0 8 34 41 43 55 51 61 ) ],
        );
        $g->add_dataset(
            data => [ qw( 3 4 9 15 32 42 52 46 40 47 53 59 ), undef, qw( 51 48 40 41 16 14 3  ) ]
        );
        $g->add_marker(
            dataset_index => 1,
            type => 's',
            color => 'FF0000',
            point => 1,
            size => 10
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=lc&chd=s:Hello,1olrd&chs=200x125&chm=o,ff9900,0,-1,10.0|d,ff9900,1,-1,10.0' => sub {
        my $g = Google::Chart->create(
            Line => (
                size => '200x125',
                encoding_class => 'Simple',
            )
        );
        $g->add_dataset(
            data => [ qw( 7 30 37 37 40 ) ],
        );
        $g->add_dataset(
            data => [ qw( 53 40 37 43 29 ) ],
        );
        $g->add_marker(
            dataset_index => 0,
            type => 'o',
            color => 'ff9900',
            point => -1,
            size => 10,
        );
        $g->add_marker(
            dataset_index => 1,
            type => 'd',
            color => 'ff9900',
            point => -1,
            size => 10,
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=bhg&chd=t:40,60|50,30&chs=200x125&chm=tApril+mobile+hits,000000,0,0,13|tMay+mobile+hits,000000,0,1,13,-1|tApril+desktop+hits,000000,1,0,13|tMay+desktop+hits,000000,1,1,13&chco=FF9900,FFCC33' => sub {
        my $g = Google::Chart->create(
            Bar => (
                orientation => 'horizontal',
                size => '200x125',
            )
        );
        $g->add_dataset(
            color => 'FF9900',
            data => [ qw(40 60) ],
        );
        $g->add_dataset(
            color => 'FFCC33',
            data => [ qw(50 30) ],
        );
        $g->add_marker(
            dataset_index => 0,
            type => 'tApril mobile hits',
            color => '000000',
            size => 13,
            point => 0,
        );
        $g->add_marker(
            dataset_index => 1,
            type => 'tApril desktop hits',
            color => '000000',
            size => 13,
            point => 0,
        );
        $g->add_marker(
            dataset_index => 0,
            type => 'tMay mobile hits',
            color => '000000',
            size => 13,
            point => 1,
            priority => -1,
        );
        $g->add_marker(
            dataset_index => 1,
            type => 'tMay desktop hits',
            color => '000000',
            size => 13,
            point => 1,
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=lc&chd=s:9gounjqGJD&chco=008000&chls=2.0,4.0,1.0&chxt=x,y&chxl=0:|Sep|Oct|Nov|Dec|1:||50|100&chs=200x125&chm=r,E5ECF9,0,0.75,0.25|r,000000,0,0.1,0.11' => sub {
        my $g = Google::Chart->create(
            Line => (
                size => '200x125',
                encoding_class => 'Simple',
            )
        );
        $g->add_range_marker(
            orientation => 'horizontal',
            color => 'E5ECF9',
            start => 0.75,
            end => 0.25,
        );
        $g->add_range_marker(
            orientation => 'horizontal',
            color => '000000',
            start => 0.1,
            end => 0.11
        );
        $g->add_axis(
            location => 'x',
            labels => [ qw(Sep Oct Nov Dec) ],
        );
        $g->add_axis(
            location => 'y',
            labels => [ undef, 50, 100 ],
        );
        $g->add_dataset(
            color => '008000',
            data => [ qw(61 32 40 46 39 35 42 6 9 3 ) ],
            line_thickness => 2.0,
            line_segment_length => 4.0,
            blank_segment_length => 1.0,
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=lc&chd=s:9gounjqGJD&chco=008000&chls=2.0,4.0,1.0&chxt=x,y&chxl=0:|Sep|Oct|Nov|Dec|1:||50|100&chs=200x125&chm=R,A0BAE9,0,0.75,0.25|R,ff0000,0,0.1,0.11' => sub {
        my $g = Google::Chart->create(
            Line => (
                size => '200x125',
                encoding_class => 'Simple',
            )
        );
        $g->add_range_marker(
            orientation => 'vertical',
            color => 'ff0000',
            start => 0.1,
            end => 0.11
        );
        $g->add_range_marker(
            orientation => 'vertical',
            color => 'A0BAE9',
            start => 0.75,
            end => 0.25
        );
        $g->add_axis(
            location => 'x',
            labels => [ qw(Sep Oct Nov Dec) ],
        );
        $g->add_axis(
            location => 'y',
            labels => [ undef, 50, 100 ],
        );
        $g->add_dataset(
            color => '008000',
            data => [ qw(61 32 40 46 39 35 42 6 9 3 ) ],
            line_thickness => 2.0,
            line_segment_length => 4.0,
            blank_segment_length => 1.0,
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=lc&chd=s:9gounjqGJD&chco=008000&chls=2.0,4.0,1.0&chxt=x,y&chxl=0:|Sep|Oct|Nov|Dec|1:||50|100&chs=200x125&chm=R,ff0000,0,0.1,0.11|R,A0BAE9,0,0.75,0.25|r,E5ECF9,0,0.75,0.25|r,000000,0,0.1,0.11' => sub {
        my $g = Google::Chart->create(
            Line => (
                size => '200x125',
                encoding_class => 'Simple',
            )
        );
        $g->add_range_marker(
            orientation => 'vertical',
            color => 'ff0000',
            start => 0.1,
            end => 0.11
        );
        $g->add_range_marker(
            orientation => 'vertical',
            color => 'A0BAE9',
            start => 0.75,
            end => 0.25
        );
        $g->add_range_marker(
            orientation => 'horizontal',
            color => 'E5ECf9',
            start => 0.75,
            end => 0.25,
        );
        $g->add_range_marker(
            orientation => 'horizontal',
            color => '000000',
            start => 0.1,
            end => 0.11
        );
        $g->add_axis(
            location => 'x',
            labels => [ qw(Sep Oct Nov Dec) ],
        );
        $g->add_axis(
            location => 'y',
            labels => [ undef, 50, 100 ],
        );
        $g->add_dataset(
            color => '008000',
            data => [ qw(61 32 40 46 39 35 42 6 9 3 ) ],
            line_thickness => 2.0,
            line_segment_length => 4.0,
            blank_segment_length => 1.0,
        );
        return $g;
    },
    'http://chart.apis.google.com/chart?cht=ls&chs=200x125&chd=s:HElowors1&chm=r,000000,0,0.499,0.501|r,000000,0,0.998,1.0|r,000000,0,0.0,0.002&chxt=r&chxl=0:|0|5|10' => sub {
        my $g = Google::Chart->create(
            SparkLine => (
                size => '200x125',
                encoding_class => 'Simple',
            )
        );
        $g->add_range_marker(
            orientation => 'horizontal',
            color => '000000',
            start => 0,
            end => 0.002,
        );
        $g->add_range_marker(
            orientation => 'horizontal',
            color => '000000',
            start => 0.499,
            end => 0.501,
        );
        $g->add_range_marker(
            orientation => 'horizontal',
            color => '000000',
            start => 0.998,
            end => 1.0,
        );
        $g->add_axis(
            location => 'r',
            labels => [ qw(0 5 10) ],
        );
        $g->add_dataset(
            data => [ qw(7 4 37 40 48 40 43 44 53) ],
        );
        return $g;
    },
);

sub samples { @charts };

1;