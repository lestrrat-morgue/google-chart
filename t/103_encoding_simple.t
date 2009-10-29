use strict;
use Test::More (tests => 8);
use Test::MockObject;

BEGIN
{
    use_ok("Google::Chart::Data");
    use_ok("Google::Chart::Encoding::Simple");
}

{
    my $data = Google::Chart::Data->new(
        encoding => Google::Chart::Encoding::Simple->new(),
    );
    $data->add_dataset(
        Google::Chart::DataSet->new(
            data => [ 0, 1, 25, 26, 27, 51, 52, 61, undef, '_' ],
        )
    );


    ok($data);
    isa_ok($data, "Google::Chart::Data");
    my @query = $data->prepare_query( Test::MockObject->new() );
    note(@query);
    is_deeply( [@query], [ chd => 's:ABZabz09__' ] );
}

{
    my $data = Google::Chart::Data->new(
        encoding => Google::Chart::Encoding::Simple->new(),
    );
    $data->add_dataset(
        Google::Chart::DataSet->new(
            data => [ 0, 1, 25, 26, 27, 51, 52, 61, undef, '_' ],
        )
    );
    $data->add_dataset(
        Google::Chart::DataSet->new(
            data => [ '_', undef, 61, 52, 51, 27, 26, 25, 1, 0 ],
        )
    );

    ok($data);
    isa_ok($data, "Google::Chart::Data");
    my @query = $data->prepare_query( Test::MockObject->new() );
    note(@query);
    is_deeply( [@query], [ chd => 's:ABZabz09__,__90zbaZBA'] )
}

