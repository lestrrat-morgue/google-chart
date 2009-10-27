package Google::Chart::WithData;
use Moose::Role;
use namespace::clean -except => qw(meta);

# guess what, not all Chart types have datasets associated with it.
# so we make this a role

has data => (
    is       => 'ro',
    isa      => 'Google::Chart::Data',
    coerce   => 1,
    required => 1
);

around prepare_query => sub {
    my ($next, $self, @args) = @_;
    my $query = $next->( $self, @args );

    my @params = $self->data->as_query( $self );
    while (@params) {
        my ($name, $value) = splice(@params, 0, 2);
        next unless length $value;
        $query->{$name} = $value;
    }
    return $query;
};

1;
