# $Id$

package Test::Google::Chart;
use strict;
use warnings;
use Google::Chart;
use IO::Socket::INET;

use Exporter 'import';

our @EXPORT_OK = qw(have_connection);

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

1;