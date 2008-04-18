package Google::Chart;

use strict;
use warnings;
use LWP::UserAgent;


our $VERSION = '0.03';


use base qw(
    Google::Chart::Base
    Google::Chart::Factory
);


__PACKAGE__
    ->mk_scalar_accessors(qw(title ua))
    ->mk_factory_typed_accessors('Google::Chart::Factory',
        data       => 'data',
        type       => 'type',
        size       => 'size',
        color_data => 'color_data',
    );


use constant DEFAULTS => (
    ua => LWP::UserAgent->new,
);


use constant API_URI => 'http://chart.apis.google.com/chart?';


sub make_obj {
    my $self = shift;
    Google::Chart::Factory->make_object_for_type(@_);
}


# Convenience methods for using underlying objects

sub set_size {
    my $self = shift;
    my ($x, $y);
    if (@_ == 1 && ref $_[0] eq 'ARRAY') {
        ($x, $y) = @{ $_[0] };
    } else {
        ($x, $y) = @_;
    }
    $self->size->x($x);
    $self->size->y($y);
}


sub type_name {
    my ($self, $type_name, @args) = @_;
    $self->type($self->make_obj($type_name, @args));
}


sub data_spec {
    my ($self, $args) = @_;
    die "data_spec has no 'encoding' key\n" unless $args->{encoding};
    my $encoding = delete $args->{encoding};
    $self->data($self->make_obj($encoding, %$args));
}


sub colors {
    my ($self, @args) = @_;
    @args =
        map { $self->make_obj('color')->guess($_) }
        @args;
    $self->color_data(colors => \@args);
}


# End of convenience methods


sub validate {
    my $self = shift;
    my @error = map { $self->$_->validate } qw(
        size type data color_data
    );
    die join "\n" => @error if @error;
}


sub get_url {
    my $self = shift;
    my $url = $self->API_URI .
        join '&' =>
        map { $self->$_->as_string }
        grep { $self->$_->has_content }
        qw(size data type color_data);
}


sub img_tag {
    my $self = shift;
    my $url = $self->get_url;
    $url =~ s/&/&amp;/g;
    qq{<IMG SRC="$url" />};
}


sub render {
    my $self = shift;
    my $response = $self->ua->get($self->get_url);

    if ($response->is_success) {
        return $response->content;
    } else {
        die $response->status_line;
    }
}


sub render_to_file {
    my ($self, $filename) = @_;

    open my $fh, '>', $filename or die "can't open $filename for writing: $!\n";
    print $fh $self->render;
    close $fh or die "can't close $filename: $!\n";
}


1;


__END__

{% USE p = PodGenerated %}

=head1 NAME

{% p.package %} - Draw a chart with Google Chart

=head1 SYNOPSIS

    use Google::Chart;
    
    my $chart = Google::Chart->new(
        type_name => 'type_pie_3d',
        set_size  => [ 300, 100 ],
        data_spec => {
            encoding  => 'data_simple_encoding',
            max_value => 100,
            value_sets => [ [ map { $_ * 10 } 0..10 ] ],
        },
    );

    print $chart->get_url;
    $chart->render_to_file('my_chart.png');

=head1 WARNING

This is a very early alpha release. It is more a proof of concept, but for
very simple cases it already works. Documentation and more complete support of
the Google Chart API will follow shortly. For now, the code more or less is
the documentation. Patches welcome.

I've neverthless released the distribution, in the I<spirit of one-point-oh>,
as Douglas Coupland puts it, or rather, in the spirit of point-oh-one.

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

