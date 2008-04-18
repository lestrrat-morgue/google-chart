package Google::Chart::Data::ExtendedEncoding;

# $Id: ExtendedEncoding.pm 307 2008-02-02 15:40:09Z queinnec $
# Copyright 2008 by Christian Queinnec

use strict;
use warnings;


our $VERSION = '0.04';


use base qw(Google::Chart::Data);


use constant ENCODING_TYPE_VALUE => 'e';


my @map = ('A'..'Z', 'a'..'z', 0..9, '-', '.');


# Due to rounding errors, max_value may be encoded as .- instead of ..

sub encode_value_set {
    my ($self, $value_set) = @_;
    my $result = '';

    for my $value ( @{$value_set} ) {
        if ( $self->is_number($value) ) {
            # Normalize value
            my $scale = (scalar(@map) * scalar(@map)) - 1;
            my $normalized_value = int(($value * $scale) / $self->max_value);

            # Truncate values out of [0 .. max_value]
            $normalized_value = 0
              if $normalized_value <= 0;
            $normalized_value = $self->max_value - 1
              if $normalized_value >= $self->max_value;

            my $hi  = int($normalized_value / scalar(@map));
            my $low = int($normalized_value % scalar(@map));
            # warn "value=$value, normalized_value=$normalized_value, hi=$hi, low=$low\n";
            $result .= $map[$hi] . $map[$low];
        } else {
            $result .= '__';
        }
    }
    $result;
}

1;

__END__

{% USE p = PodGenerated %}

=head1 NAME

{% p.package %} - Extended encodings of sets of values

=head1 SYNOPSIS

    use Google::Chart;
    my $chart = Google::Chart->new(
        type_name => 'type_line',
        set_size  => [ 300, 100 ],
        data_spec => {
            encoding  => 'data_extended_encoding',
            max_value => 64*64-1,
            value_sets => [ [ -1, 0, 64], [ 64*63, 64*64-1, 64*64 ] ],
        },
    );

=head1 DESCRIPTION

This module encodes sets of values with the "extended encoding" rules as
defined by Google (see L<http://code.google.com/apis/chart/>). 4096 final
values are possible with that encoding, whereas only 62 values are possible
with simple encoding, see L<Google::Chart::Data::SimpleEncoding> for further
details.

The specified values are first normalized with respect to the specified
max_value then scaled to spread the [0..4096[ interval.  Values out of
[0..max_value[ are considered to be, 0 or max_value respectively.
Non-numerical values are mapped onto undefined values encoded as C<__>.

=head1 WARNINGS

Due to rounding errors, a value equals to max_value may encoded as C<._>
instead of C<..>.

=head1 METHODS

=over 4

{% p.write_methods %}

=back

{% p.write_inheritance %}

{% PROCESS standard_pod
    local_authors = [ 'Christian Queinnec C<< christian@queinnec.org >>' ]
%}

=cut

