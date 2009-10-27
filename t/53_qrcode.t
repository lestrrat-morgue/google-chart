use strict;
use utf8;
use Test::More (tests => 7);
use Test::Exception;

BEGIN
{
    use_ok("Google::Chart");
}

{
    my $chart = Google::Chart->create(
        QRcode => (
            text => "Hello World",
        )
    );

    ok( $chart );
    isa_ok( $chart, "Google::Chart" );

    my $uri = $chart->as_uri;
    note $uri;
    my %h = $uri->query_form;
    is( $h{cht}, "qr" );
}

{
    my $chart = Google::Chart->create(
        QRcode => (
            text => Encode::encode_utf8("諸行無常")
        )
    );

    ok( $chart );
    isa_ok( $chart, "Google::Chart" );

    my $uri = $chart->as_uri;
    note $uri;
    my %h = $uri->query_form;
    is( $h{cht}, "qr" );
}

