package Google::Chart::Data;

use strict;
use warnings;


our $VERSION = '0.03';


use base qw(Google::Chart::Base);


__PACKAGE__
    ->mk_scalar_accessors(qw(max_value))
    ->mk_array_accessors(qw(value_sets))
    ->mk_abstract_accessors(qw(encode_value_set));


sub has_content {
    my $self = shift;
    $self->value_sets_count;
}


sub as_string {
    my $self = shift;
    sprintf 'chd=s:%s',
        join ',' =>
        map { $self->encode_value_set($_) }
        $self->value_sets;
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

