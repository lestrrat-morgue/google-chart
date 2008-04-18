package Google::Chart::Data::SimpleEncoding;

use strict;
use warnings;
use Data::Dumper;


our $VERSION = '0.03';


use base qw(Google::Chart::Data);


sub encode_value_set {
    my ($self, $value_set) = @_;

    unless (ref $value_set eq 'ARRAY') {
        die "value set is not an array reference\n", Dumper $value_set;
    }

    my $result = '';
    my @map = ('A'..'Z', 'a'..'z', 0..9);
    for my $value (@$value_set) {
        if ($self->is_number($value)) {
            my $index = int($value / $self->max_value * (@map - 1));
            $index = 0 if $index < 0;
            $index = @map if $index > @map;
            $result .= $map[$index];
        } else {
            $result .= '_';
        }
    }
    $result;
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

=head1 METHODS

=over 4

{% p.write_methods %}

=back

{% p.write_inheritance %}

{% PROCESS standard_pod %}

=cut

