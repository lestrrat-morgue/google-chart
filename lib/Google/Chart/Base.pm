package Google::Chart::Base;

use strict;
use warnings;


our $VERSION = '0.04';


use base qw(
    Class::Accessor::Complex
    Class::Accessor::Constructor
    Class::Accessor::FactoryTyped
);


__PACKAGE__->mk_constructor;


sub validate {}


# taken from Test::Numeric

sub is_number {
    my ($self, $number) = @_;

    return 0 unless defined $number && length $number;

    # Accept obviously right things.
    return 1 if $number =~ m/^\d+$/;

    # Throw out obviously wrong things.
    return 0 if $number =~ m/[^+\-\.eE0-9]/;

    # Split the number into parts.
    my ( $num, $e, $exp ) = split /(e|E)/, $number, 2;

    # Check that the exponent is valid.
    if ($e) { return 0 unless $exp =~ m/^[+\-]?\d+$/; }

    # Check the number.
    return 0 unless $num =~ m/\d/;
    return 0 unless $num =~ m/^[+\-]?\d*\.?\d*$/;

    return 1;
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

