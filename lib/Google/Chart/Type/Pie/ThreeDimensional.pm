package Google::Chart::Type::Pie::ThreeDimensional;

use strict;
use warnings;


our $VERSION = '0.03';


use base qw(Google::Chart::Type::Pie);


use constant as_string => 'cht=p3';


1;


__END__

{% USE p = PodGenerated %}

=head1 NAME

{% p.package %} - Draw a chart with Google Chart

=head1 SYNOPSIS

    {% p.package %}->new;

=head1 WARNING

This is a very early alpha release. It is more a proof of concept, but for
very simple cases it already works. Documentation and more complete support of
the Google Chart API will follow shortly. For now, the code more or less is
the documentation. Patches welcome.

=head1 DESCRIPTION

This set of classes uses the Google Chart API - see
L<http://code.google.com/apis/chart/> - to draw charts.

{% p.write_inheritance %}

{% PROCESS standard_pod %}

=cut

