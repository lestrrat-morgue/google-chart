use strict;
use Test::More (tests => 7);
use Test::Exception;

BEGIN
{
    use_ok("Google::Chart");
}

{
    my $graph = Google::Chart->create(
        Line => (
            size => '300x300',
        )
    );
    $graph->add_axis(
        location => 'x',
        labels => [1, 2, 3],
    );
    $graph->add_dataset(
        color => 'ff0000',
        data => [20, 40, 90],
    );
    ok($graph);
    isa_ok($graph, 'Google::Chart');
    my $uri = $graph->as_uri;
    note ($uri);
    my %h = $uri->query_form;
    is( $h{chco}, 'ff0000' );
}
{
    my $graph = Google::Chart->create(
        Line => (
            size => '300x300',
        )
    );
    $graph->add_axis(
        location => 'x',
        labels => [1, 2, 3],
    );
    $graph->add_axis(
        location => 'y',
        labels => [0,25,50,75,100],
    );
    $graph->add_dataset(
        color => 'ff0000',
        data => [20, 40, 90], 
    );
    $graph->add_dataset(
        color => '00ffff',
        data => [100, 70, 20],
    );
    ok($graph);
    isa_ok($graph, 'Google::Chart');
    my $uri = $graph->as_uri;
    note ($uri);
    my %h = $uri->query_form;
    is( $h{chco}, 'ff0000,00ffff' );
}
