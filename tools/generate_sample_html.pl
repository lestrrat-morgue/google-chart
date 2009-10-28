use strict;
use lib "t/lib";
use Data::Dumper;
use Test::Google::Chart::Samples;

my @samples = Test::Google::Chart::Samples->samples;
print <<EOHTML;
<html>
<head>
    <title>Google::Chart Samples</title>
</head>
<body>
<h1>Google::Chart Sample</h1>
<div><strong>(generated on @{[scalar localtime]})</strong></div>

<div>These samples were taken from the Google Chart API Developer's Manual</div>

EOHTML
while (@samples) {
    my ($uri, $code) = splice(@samples, 0, 2);

    my $g = $code->();
    next unless $g;
    my $generated_uri = $g->as_uri;
    local $Data::Dumper::Indent = 1;
    local $Data::Dumper::Deparse = 1;
    my $code_str = Dumper($code);
    $code_str =~ s/\$VAR1 = //;
    $code_str =~ s/    use strict 'refs';\n//;
    $code_str =~ s/    package Test::Google::Chart::Samples;\n//;
    $code_str =~ s/'Google::Chart'/Google::Chart/g;
    print <<EOHTML;
<div style="margin-top: 20px; padding: 20px; border-bottom: 1px solid #000">
<table style="margin: 0 auto">
    <tr>
        <td colspan="2"><input type="text" style="font-size: 9pt; width: 600px" value="$uri"></td>
    </tr>
    <tr>
        <td align="middle">From the Manual</td>
        <td align="middle">Generated</td>
    </tr>
    <tr>
        <td align="middle"><img style="border: 1px solid #000; margin: 0 auto" src="$uri"></td>
        <td align="middle"><img style="border: 1px solid #f00; margin: 0 auto" src="$generated_uri"></td>
    </tr>
    <tr>
        <td colspan="2">
            <div style="font-size: 9pt; padding-left: 1em; width: 600px; height: 150px; overflow: auto; border: 1px solid #ccc; background-color: #eee"><pre>$code_str</pre></div>
        </td>
    </tr>
</table>
</div>
EOHTML
}
print <<EOHTML;
</body>
</html>
EOHTML

