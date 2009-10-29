use strict;
use Test::More (tests => 11);
use Test::Exception;
use Test::MockObject;

BEGIN
{
    use_ok("Google::Chart::Data");
    use_ok("Google::Chart::Encoding::Extended");
}

{
    my $data = Google::Chart::Data->new(
        encoding => Google::Chart::Encoding::Extended->new(
            max_value => 150,
        ),
    );
    $data->add_dataset(
        Google::Chart::DataSet->new(
            data => [ 1.0, 1.2, 1.3, 50, 100 ],
        )
    );

    ok($data);
    isa_ok($data, "Google::Chart::Data");
    my @query = $data->prepare_query( Test::MockObject->new() );
    note(@query);
    is_deeply( [@query], [ chd => 'e:AbAgAjVVqq' ] );
}
{
    my $data = Google::Chart::Data->new(
        encoding => Google::Chart::Encoding::Extended->new(
            max_value => 150,
        ),
    );
    $data->add_dataset(
        Google::Chart::DataSet->new(
            data => [ 1.0, 1.2, 1.3, 50, 100 ],
        )
    );
    $data->add_dataset(
        Google::Chart::DataSet->new(
            data => [ 100, 50, 1.3, 1.2, 1.0 ],
        )
    );

    ok($data);
    isa_ok($data, "Google::Chart::Data");
    my @query = $data->prepare_query( Test::MockObject->new() );
    note(@query);
    is_deeply( [@query], [ chd => 'e:AbAgAjVVqq,qqVVAjAgAb' ] );
}

{
    my $data = Google::Chart::Data->new(
        encoding => Google::Chart::Encoding::Extended->new(
            max_value => 150,
            min_value => -50,
        ),
    );
    $data->add_dataset(
        Google::Chart::DataSet->new(
            data => [ -10, -40, 10, 70, 100 ],
        )
    );
    $data->add_dataset(
        Google::Chart::DataSet->new(
            data => [ 100, 50, -0.5, 2, -35.7 ],
        )
    );

    ok($data);
    isa_ok($data, "Google::Chart::Data");
    my @query = $data->prepare_query( Test::MockObject->new() );
    note(@query);
    is_deeply( [@query], [ chd => 'e:MzDMTMmZv.,v.f.P1QoEk' ]);
}

