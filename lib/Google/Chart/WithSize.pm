package Google::Chart::WithSize;
use Moose::Role;
use namespace::clean -except => qw(meta);

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

around BUILDARGS => sub {
    my ($next, $self, @args) = @_;
    my $args = $next->($self, @args);

    if (my $size = delete $args->{size}) {
        my ($width, $height) = split /x/, $size;
        $args->{width} = $width;
        $args->{height} = $height;
    }

    return $args;
};

around prepare_query => sub {
    my ($next, $self, @args) = @_;
    my @query = $next->($self, @args);
    push @query, ( chs => join('x', $self->width, $self->height ) );
    return @query;
};

1;
