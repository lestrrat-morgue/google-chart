
package Google::Chart::Size;
use Moose;
use Scalar::Util qw(looks_like_number);
use namespace::clean -except => qw(meta);

with 'Google::Chart::QueryComponent';

has width => (
    is       => 'rw',
    isa      => 'Int',
    required => 1
);

has height => (
    is       => 'rw',
    isa      => 'Int',
    required => 1
);

sub BUILDARGS {
    my ($class, @args) = @_;

    my %args;

    if (@args == 2 && looks_like_number($args[0]) && looks_like_number($args[0]) ) {
        $args{width} = $args[0];
        $args{height} = $args[1];
    } else {
        %args = @args;
    }

    return \%args;
}

sub as_query {
    my $self = shift;
    return ( chs => join('x', $self->width, $self->height) );
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

Google::Chart::Size - Google::Chart Size Specification

=head1 SYNOPSIS

  Google::Chart->new(
    size => "400x300"
  )

  Google::Chart->new( 400, 300 )

  Google::Chart->new(
    size => {
      width => 400,
      height => 300
    }
  )

=head1 METHODS

=cut
