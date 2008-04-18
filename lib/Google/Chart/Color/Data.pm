package Google::Chart::Color::Data;

use strict;
use warnings;


our $VERSION = '0.04';


use base qw(Google::Chart::Base);


__PACKAGE__
    ->mk_factory_typed_array_accessors('Google::Chart::Factory',
        color => 'colors',
    ); 


sub has_content {
    my $self = shift;
    $self->colors_count;
}


sub as_string {
    my $self = shift;
    'chco=' . join ',' => map { $_->hex } $self->colors;
}


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

