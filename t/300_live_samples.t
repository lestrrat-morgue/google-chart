use strict;
use lib "t/lib";
use Test::Google::Chart qw(have_connection);
use Test::More;
use LWP::UserAgent;
use Digest::MD5 qw(md5_hex);

if (! $ENV{AUTHOR_TEST}) {
    plan skip_all => "author tests (set AUTHOR_TEST to enable)";
} elsif (! have_connection()) {
    plan skip_all => "No connection";
}

my $ua = LWP::UserAgent->new();
my @samples = Test::Google::Chart->samples();
while (@samples) {
    my ($o_uri, $code) = splice(@samples, 0, 2);

    my $g = $code->();
    next unless $g;
    my $g_uri = $g->as_uri;

    my $o_res = $ua->get( $o_uri );
    my $g_res = $ua->get( $g_uri );

    # binary data looks bad, so take the has for both, and compare them
    my $o_hash = md5_hex( $o_res->content );
    my $g_hash = md5_hex( $g_res->content );

    is( $g_hash, $o_hash, "content for $o_uri <-> $g_uri is the same" );
}

done_testing();


