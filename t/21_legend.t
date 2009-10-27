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
    my $graph = Google::Chart->new(
        type => 'Line',
        size => '300x300',
        data => Google::Chart::Data->new(
            data => [
                Google::Chart::DataSet->new(
                    data => [[20, 40, 90], [100, 70, 20]],
                    legend => 'data1',
                )
            ]
        ),
        axis => Google::Chart::Axis->new(
            axes => [
                Google::Chart::Axis::Item->new(
                    location => 'x',
                    labels => [1, 2, 3],
                ),
                Google::Chart::Axis::Item->new(
                    location => 'y',
                    labels => [0,25,50,75,100],
                )
            ],
        ),
        color => ['ff0000', '00ffff'],
    );
    ok($graph);
    isa_ok($graph, 'Google::Chart');
    my $uri = $graph->as_uri;
    note ($uri);
    my %h = $uri->query_form;
    is( $h{chdl}, 'data1' );
}

{
    my $graph = Google::Chart->new(
        type => 'Line',
        size => '300x300',
        data => Google::Chart::Data->new(
            data => [
                Google::Chart::DataSet->new(
                    legend => 'data1',
                    data => [20, 40, 90],
                ),
                Google::Chart::DataSet->new(
                    legend => 'data2',
                    data =>  [100, 70, 20],
                )
            ]
        ),
        axis => Google::Chart::Axis->new(
            axes => [
                Google::Chart::Axis::Item->new(
                    location => 'x',
                    labels => [1, 2, 3],
                ),
                Google::Chart::Axis::Item->new(
                    location => 'y',
                    labels => [0,25,50,75,100],
                )
            ],
        ),
        color => ['ff0000', '00ffff'],
    );
    ok($graph);
    isa_ok($graph, 'Google::Chart');
    my $uri = $graph->as_uri;
    note ($uri);
    my %h = $uri->query_form;
    is( $h{chdl}, 'data1|data2' );
}
