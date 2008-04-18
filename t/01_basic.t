#!/usr/bin/env perl

use warnings;
use strict;
use Google::Chart;
use Test::More tests => 4;

my $chart = Google::Chart->new(
    type_name => 'type_pie_3d',
    set_size  => [ 300, 100 ],
    data_spec => {
        encoding  => 'data_simple_encoding',
        max_value => 100,
        value_sets => [ [ map { $_ * 10 } 0..10 ] ],
    },
);

is(
    $chart->get_url,
    'http://chart.apis.google.com/chart?chs=300x100&chd=s:AGMSYekqw29&cht=p3',
    'basic 3d pie chart',
);

$chart->type_name('type_line');

is(
    $chart->get_url,
    'http://chart.apis.google.com/chart?chs=300x100&chd=s:AGMSYekqw29&cht=lc',
    'basic line chart',
);

$chart->colors('FF0000');

is(
    $chart->get_url,
    'http://chart.apis.google.com/chart?chs=300x100&chd=s:AGMSYekqw29&cht=lc&chco=FF0000',
    'basic line chart with color',
);

my $c2 = $chart->make_obj('color')->rgbt([ 0, 255, 127, 90 ]);
$chart->color_data->colors_push($c2);

is(
    $chart->get_url,
    'http://chart.apis.google.com/chart?chs=300x100&chd=s:AGMSYekqw29&cht=lc&chco=FF0000,00FF7F5a',
    'basic line chart two colors',
);
