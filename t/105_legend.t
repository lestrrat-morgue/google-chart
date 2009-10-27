use strict;
use Test::More (tests => 14);
use Test::Exception;

BEGIN
{
    use_ok("Google::Chart::Legend");
    use_ok("Google::Chart");
}

{
    my $color = Google::Chart::Legend->new(
        values => ['data1','data2'],
    );

    ok($color);
    isa_ok($color, "Google::Chart::Legend");
    my $query = $color->as_query;
    note($query);
    is( $query, "chdl=data1%7Cdata2" );
}
{
    my $color = Google::Chart::Legend->new(
        values => 'data1',
    );

    ok($color);
    isa_ok($color, "Google::Chart::Legend");
    my $query = $color->as_query;
    note($query);
    is( $query, "chdl=data1" );
}

{
    my $graph = Google::Chart->create(
        Line => (
            size => '300x300',
        )
    );
    $graph->add_dataset(
        legend => 'data1',
        data => [20, 40, 90],
        color => 'ff0000',
    );
    $graph->add_dataset(
        data => [100, 70, 20],
        color => '00ffff',
    );
    $graph->add_axis(
        location => 'x',
        labels => [1, 2, 3],
    );
    $graph->add_axis(
        location => 'y',
        labels => [0,25,50,75,100],
    );
    ok($graph);
    isa_ok($graph, 'Google::Chart');
    my $uri = $graph->as_uri;
    note ($uri);
    my %h = $uri->query_form;
    is( $h{chdl}, 'data1' );
}

{
    my $graph = Google::Chart->create(
        Line => (
            size => '300x300',
        )
    );
    $graph->add_dataset(
        color => 'ff0000',
        legend => 'data1',
        data => [20, 40, 90],
    );
    $graph->add_dataset(
        color => '00ffff',
        legend => 'data2',
        data =>  [100, 70, 20],
    );
    $graph->add_axis(
        location => 'x',
        labels => [1, 2, 3],
    );
    $graph->add_axis(
        location => 'y',
        labels => [0,25,50,75,100],
    );
    ok($graph);
    isa_ok($graph, 'Google::Chart');
    my $uri = $graph->as_uri;
    note ($uri);
    my %h = $uri->query_form;
    is( $h{chdl}, 'data1|data2' );
}
