use strict;
use Test::More (tests => 4);


BEGIN {
    use_ok("Google::Chart");
}

{
    local $ENV{HTTP_PROXY} = '';
    my $g = Google::Chart->new(type => 'Line');
    ok(! $g->ua->proxy('http'), "http proxy should not be set");
}

{
    local $ENV{HTTP_PROXY} = 'http://localhost:3128';
    my $g = Google::Chart->new(type => 'Line');
    is($g->ua->proxy('http'), $ENV{HTTP_PROXY}, "http proxy should be set");
}

{
    local $ENV{HTTP_PROXY} = 'http://localhost:3128';
    local $ENV{GOOGLE_CHART_ENV_PROXY} = 0;
    my $g = Google::Chart->new(type => 'Line');
    ok(! $g->ua->proxy('http'), "http proxy should not be set");
}

