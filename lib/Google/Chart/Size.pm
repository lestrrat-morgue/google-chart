package Google::Chart::Size;

use strict;
use warnings;


our $VERSION = '0.03';


use base qw(Google::Chart::Base);


__PACKAGE__->mk_scalar_accessors(qw(x y));


sub validate {
    my ($self, $chart) = @_;

    my @error;

    if ($self->size_x < 0) {
        push @error, sprintf 'width [%s] is negative', $self->size_x;
    }

    if ($self->size_x == 0) {
        push @error, sprintf 'width [%s] is zero', $self->size_x;
    }

    if ($self->size_x > 1000) {
        push @error, sprintf 'width [%s] is greater than 1000', $self->size_x;
    }

    if ($self->size_y < 0) {
        push @error, sprintf 'height [%s] is negative', $self->size_y;
    }

    if ($self->size_y == 0) {
        push @error, sprintf 'height [%s] is zero', $self->size_y;
    }

    if ($self->size_y > 1000) {
        push @error, sprintf 'height [%s] is greater than 1000', $self->size_x;
    }

    if ($self->size_x * $self->size_y > 300_000) {
        push @error, sprintf 'area is more than 300,000 pixels';
    }

    @error;
}


sub has_content {
    my $self = shift;
    defined($self->x) && defined $self->y;
}


sub as_string {
    my $self = shift;
    sprintf 'chs=%sx%s', int($self->x), int($self->y);
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

