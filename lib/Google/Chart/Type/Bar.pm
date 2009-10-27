
package Google::Chart::Type::Bar;
use Moose;
use Moose::Util::TypeConstraints;
use namespace::clean -except => qw(meta);

with 'Google::Chart::Type';

enum 'Google::Chart::Type::Bar::Orientation' => qw(horizontal vertical);

has stacked => (
    is       => 'rw',
    isa      => 'Bool',
    default  => 1,
);

has orientation => (
    is      => 'rw',
    isa     => 'Google::Chart::Type::Bar::Orientation',
    default => 'vertical',
);

sub as_query {
    my $self = shift;
    return (
        cht => sprintf( 'b%s%s', 
            $self->orientation eq 'vertical' ? 'v' : 'h',
            $self->stacked                   ? 's' : 'g'
        )
    );
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

Google::Chart::Type::Bar - Google::Chart Bar Type

=head1 SYNOPSIS

  Google::Chart::Bar->new(
     stacked     => 1,
     orientation => "horizontal",
  );

=cut