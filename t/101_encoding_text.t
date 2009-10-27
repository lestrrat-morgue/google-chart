use strict;
use Test::More (tests => 7);

BEGIN
{
    use_ok("Google::Chart::Data");
}

{
    my $data = Google::Chart::Data->new(
        [ 1.0, 1.2, 1.3, undef, 50, -1, 100 ]
    );

    ok($data);
    isa_ok($data, "Google::Chart::Data");
    my @query = $data->as_query;
    note(@query);
    is_deeply( [@query], [ chd => 't:1.0,1.2,1.3,-1,50.0,-1,100.0'] )
}

{
    my $data = Google::Chart::Data->new(
        [
            [ 1.0, 1.2, 1.3, undef, 50, -1, 100 ],
            [ 100, -1, 50, undef, 1.3, 1.2, 1.0 ],
        ]
    );

    ok($data);
    isa_ok($data, "Google::Chart::Data");
    my @query = $data->as_query;
    note(@query);
    is_deeply( [@query], [ chd => 't:1.0,1.2,1.3,-1,50.0,-1,100.0|100.0,-1,50.0,-1,1.3,1.2,1.0'] )
}

