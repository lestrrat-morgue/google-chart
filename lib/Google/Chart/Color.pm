package Google::Chart::Color;

use strict;
use warnings;


our $VERSION = '0.04';


use base qw(Google::Chart::Base);


__PACKAGE__
    ->mk_scalar_accessors(qw(red green blue transparency));


use constant DEFAULTS => (
    red   => 0,
    green => 0,
    blue  => 0,
);


sub new_from_rgbt {
    my ($class, $rgbt) = @_;
    my $self = $class->new;
    $self->rgbt($rgbt);
    $self;
}


sub new_from_hex {
    my ($class, $hex) = @_;
    my $self = $class->new;
    $self->hex($hex);
    $self;
}


sub rgbt {
    my $self = shift;
    if (@_) {
        my ($red, $green, $blue, $transparency) = @{ $_[0] };
        $self->red($red);
        $self->green($green);
        $self->blue($blue);
        $self->transparency($transparency);
        return $self;   # for chaining
    } else {
        return [ $self->red, $self->green, $self->blue, $self->transparency ];
    }
}


sub hex {
    my $self = shift;
    if (@_) {
        my $hex = shift;
        $hex =~ s/^#//;
        $hex =~ s/(.)/$1$1/g if length($hex) == 3;
        my ($red, $green, $blue, $transparency) =
            map { defined($_) ? hex : undef }
            $hex =~ /(.{2})/g;
        $self->red($red);
        $self->green($green);
        $self->blue($blue);
        $self->transparency($transparency);
        return $self;   # for chaining
    } else {
        my $to_hex = sub { substr sprintf('0%x', shift), -2 };
        my $value = uc
            join '' =>
            map { $to_hex->($self->$_) }
            qw(red green blue);
        $value .= $to_hex->($self->transparency) if
            defined $self->transparency;
        return $value;
    }
}


sub guess {
    my ($self, $input) = @_;
    if (ref $input eq 'ARRAY') {
        $self->rgbt($input)
    } elsif (UNIVERSAL::can($input, 'rgbt')) {
        $self->rgbt($input->rgbt)
    } else {
        $self->hex($input);
    }
    $self;   # for chaining
}


sub validate {
    my ($self, $chart) = @_;
    
    my @error;
    for (qw(red green blue transparency)) {
        unless ($_ eq 'transparency' || defined $self->$_) {
            push @error, "$_ color component is not defined";
            next;
        }

        unless ($self->is_number($self->$_)) {
            push @error, "$_ color component is not a number";
            next;
        }

        my $value = int $self->$_;

        if ($value < 0) {
            push @error, "$_ color component is less than zero";
            next;
        }

        if ($value > 255) {
            push @error, "$_ color component is greater than 255";
            next;
        }
    }

    @error;
}


sub as_string {
    my $self = shift;
    my $k
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

