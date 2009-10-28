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

<table>
<tr>
    <td align="middle">From the Manual</td>
    <td align="middle">Generated</td>
    <td align="middle">Code</td>
</tr>
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
    <tr>
        <td><img src="$uri"></td>
        <td><img src="$generated_uri"></td>
        <td><div style="font-size: 9pt; width: 400px; height: 200px; overflow: auto"><pre>$code_str</pre></div></td>
    </tr>
EOHTML
}
print <<EOHTML;
</table>
</body>
</html>
EOHTML

