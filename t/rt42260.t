use strict;
use Test::More (tests => 1);
use Google::Chart;

eval {
    my $chart = Google::Chart->create(
        Line => (
            size => "400x300",
        )
    );
    $chart->data_encoding( Extended => ( max_value=> 150 ) );
    $chart->add_dataset(
        data => [ 1,50,60,20,10,130 ],
    );
};
ok( !$@) or diag($@);
