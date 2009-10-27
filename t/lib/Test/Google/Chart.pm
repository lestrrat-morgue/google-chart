
package Test::Google::Chart;
use strict;
use warnings;
use Google::Chart;
use IO::Socket::INET;
use Test::Exception;
use Test::More;

use Exporter 'import';

our @EXPORT_OK = qw(have_connection test_render);

sub have_connection {
    my $url = $ENV{GOOGLE_CHART_URI} ? 
        URI->new($ENV{GOOGLE_CHART_URI}) :
        URI->new("http://chart.apis.google.com/chart");
    my $socket = IO::Socket::INET->new(
        PeerAddr => $url->host,
        PeerPort => $url->port
    );

    if (! $socket) {
        return 0;
    } else {
        $socket->close;
        return 1;
    }
}

sub test_render {
    my $chart = shift;

    local $Test::Builder::Level = $Test::Builder::Level + 1;
    SKIP: {
        if (! have_connection()) {
            skip( "No connection to google charts API", 3 );
        }

        my $filename = 't/foo.png';

        unlink $filename;
        ok(! -f $filename );

        lives_ok { $chart->render_to_file( filename => $filename ) } "render_to_file($filename) should work";

        ok(-f $filename );
    }

}

1;