# $Id$

package Google::Chart::Size;
use Moose;
use Moose::Util::TypeConstraints;
use Google::Chart::Types qw(hash_coercion);

use constant parameter_name => 'chs';

with 'Google::Chart::QueryComponent::Simple';

coerce 'Google::Chart::Size'
    => from 'Str'
    => via {
        if (! /^(\d+)x(\d+)$/) {
            confess "Could not parse $_ as size";
        }

        return Google::Chart::Size->new(width => $1, height => $2);
    }
;

coerce 'Google::Chart::Size'
    => from 'HashRef'
    => hash_coercion( prefix => 'Google::Chart::Size', default => '+Google::Chart::Size' )
;

has 'width' => (
    is => 'rw',
    isa => 'Int',
    required => 1
);

has 'height' => (
    is => 'rw',
    isa => 'Int',
    required => 1
);

no Moose;

sub parameter_value {
    my $self = shift;
    return join('x', $self->width, $self->height);
}

1;

__END__

=head1 NAME

Google::Chart::Size - Google::Chart Size Specification

=head1 SYNOPSIS

  Google::Chart->new(
    size => "400x300"
  )

  Google::Chart->new(
    size => {
      width => 400,
      height => 300
    }
  )

=head1 METHODS

=head2 parameter_value

=cut
