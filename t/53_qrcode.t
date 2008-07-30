use strict;
use Test::More (tests => 5);
use Test::Exception;

BEGIN
{
    use_ok("Google::Chart");
}

{
    my $chart = Google::Chart->new(
        type => {
            module => "QRcode",
            args   => {
                text => "Hello World",
            }
        }
    );

    ok( $chart );
    isa_ok( $chart, "Google::Chart" );

    isa_ok( $chart->type, "Google::Chart::Type::QRcode" );

    my $uri = $chart->as_uri;
    diag $uri;
    my %h = $uri->query_form;
    is( $h{cht}, "qr" );

}
