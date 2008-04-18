package Google::Chart::Factory;

use warnings;
use strict;


our $VERSION = '0.04';


use base qw(Class::Factory::Enhanced);


__PACKAGE__->register_factory_type(
    color                  => 'Google::Chart::Color',
    color_data             => 'Google::Chart::Color::Data',
    data                   => 'Google::Chart::Data',
    data_simple_encoding   => 'Google::Chart::Data::SimpleEncoding',
    # data_text_encoding     => 'Google::Chart::Data::TextEncoding',
    data_extended_encoding => 'Google::Chart::Data::ExtendedEncoding',
    size                   => 'Google::Chart::Size',
    type                   => 'Google::Chart::Type',
    type_line              => 'Google::Chart::Type::Line::LineX',
    type_line_xy           => 'Google::Chart::Type::Line::LineXY',
    type_bar_hor_stacked   => 'Google::Chart::Type::Bar::HorizontalStacked',
    type_bar_vert_stacked  => 'Google::Chart::Type::Bar::VerticalStacked',
    type_bar_hor_grouped   => 'Google::Chart::Type::Bar::HorizontalGrouped',
    type_bar_vert_grouped  => 'Google::Chart::Type::Bar::VerticalGrouped',
    type_pie_2d            => 'Google::Chart::Type::Pie::TwoDimensional',
    type_pie_3d            => 'Google::Chart::Type::Pie::ThreeDimensional',
    type_venn              => 'Google::Chart::Type::Venn',
    type_scatter_plot      => 'Google::Chart::Type::ScatterPlot',
);


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

