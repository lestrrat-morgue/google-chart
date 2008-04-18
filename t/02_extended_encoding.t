#!/usr/bin/env perl

# $Id: ee.t 308 2008-02-02 15:40:54Z queinnec $
# Copyright 2008 by Christian Queinnec

use warnings;
use strict;
use Google::Chart;
use Test::More tests => 6;
use Test::Differences;


my $chart = Google::Chart->new(
   type_name  => 'type_line',
   set_size   => [300, 100],
   data_spec  => {
       encoding   => 'data_simple_encoding',
       max_value  => 62,
       value_sets => [ [ -1, 0, 25, 26, 52, 53, 62, 63 ],
                       [ -1, 0, 25, 26, 52, 53, 62, 63 ] ],
    },
);

# Check simple encoding
diag($chart->data->encode_value_set([0]));
diag($chart->data->encode_value_set([1, 2]));
eq_or_diff(
    $chart->data->as_string, 
    'chd=s:AAYZz099,AAYZz099',
    'simple encoding'
);

# Check extended encoding
$chart->data_spec({ 
    encoding => 'data_extended_encoding', 
    max_value => 64*64-1,
    value_sets => [ [ -1, 0, 25, 26, 53, 61, 62, 63, 64 ],
                    [ 64*63, 64*63 +1, 64*64-1 ] ] });
eq_or_diff(
    $chart->data->encode_value_set([0]),
    'AA',
    'extended encoding 0'
);

like($chart->data->encode_value_set([-1, 0, 1, 64*64]), qr/AAAAAB\.[-.]/, 
    'extended encoding 1');

like($chart->data->encode_value_set([62, 63, 64, 65]), qr/A-A\.BABB/, 
    'extended encoding 2');

like(
    $chart->data->encode_value_set([64*63, 64*64-2, 64*64-1, 64*64]),
    qr/\.A\.-\.[-.]\.[-.]/,  
    'extended encoding 3'
);

like($chart->data->as_string, qr/chd=e:AAAAAZAaA1A9A-A.BA,\.A\.B\.[-.]/, 
    'extended encoding complete');

