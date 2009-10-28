use strict;
use Test::More (tests => 7);
use Test::MockObject;

BEGIN
{
    use_ok("Google::Chart::Data");
}

{
    my $data = Google::Chart::Data->new();
    $data->add_dataset(
        data => [ 1.0, 1.2, 1.3, undef, 50, -1, 100 ]
    );

    ok($data);
    isa_ok($data, "Google::Chart::Data");
    my @query = $data->prepare_query( Test::MockObject->new() );
    note(@query);
    is_deeply( \@query, [ chd => 't:1.0,1.2,1.3,-1,50.0,-1,100.0'] )
}

{
    my $data = Google::Chart::Data->new();
    $data->add_dataset(
        data => [ 1.0, 1.2, 1.3, undef, 50, -1, 100 ]
    );
    $data->add_dataset(
        data => [ 100, -1, 50, undef, 1.3, 1.2, 1.0 ],
    );

    ok($data);
    isa_ok($data, "Google::Chart::Data");
    my @query = $data->prepare_query( Test::MockObject->new() );
    note(@query);
    is_deeply( [@query], [ chd => 't:1.0,1.2,1.3,-1,50.0,-1,100.0|100.0,-1,50.0,-1,1.3,1.2,1.0'] )
}

