use strict;
use Test::More (tests => 8);
use Test::Exception;

BEGIN
{
    use_ok("Google::Chart::Grid");
    use_ok("Google::Chart");
}

{
    my $grid = Google::Chart::Grid->new(
        x_step_size => 20,
        y_step_size => 40,
    );

    ok($grid);
    isa_ok($grid, "Google::Chart::Grid");
    my @query = $grid->as_query;
    note(@query);
    is_deeply( \@query, [ chg => "20,40,1,1" ] );
}
{
    my $graph = Google::Chart->create(
        Line => (
            size => '300x300',
            grid => {
                x_step_size => 50,
                y_step_size => 33.3,
            },
        )
    );
    $graph->data_encoding( Extended => (
        min_value => -100,
        max_value => 200,
    ) );
    $graph->add_dataset(
        legend => 'data1',
        color => 'ff0000', 
        data => [180,-67.5,4.6],
    );
    $graph->add_dataset(
        legend => 'data2',
        color => '00ffff',
        data => [-20,10,130],
    );
    $graph->add_axis(
        location => 'x',
        labels => [1, 2, 3],
    );
    $graph->add_axis(
        location => 'y',
        labels => [-100,0,100,200],
    );
    ok($graph);
    isa_ok($graph, 'Google::Chart');
    my $uri = $graph->as_uri;
    note ($uri);
    my %h = $uri->query_form;
    is( $h{chg}, '50,33.3,1,1' );
}
