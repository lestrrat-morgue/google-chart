package Google::Chart::Type::Map;
use Moose;
use Moose::Util::TypeConstraints;
use namespace::clean -except => qw(meta);

extends 'Google::Chart';

with qw(
    Google::Chart::WithData
    Google::Chart::WithSize
    Google::Chart::WithSolidFill
);

has area => (
    is => 'ro',
    isa => enum([ qw(africa asia europe middle_east south_america usa world) ]),
    required => 1,
    default => 'world',
);

has codes => (
    is => 'ro',
    isa => 'ArrayRef',
    predicate => 'has_codes',
);

has colors => (
    is => 'ro',
    isa => 'ArrayRef',
    predicate => 'has_colors',
);

sub _build_type { 't' }

around prepare_query => sub {
    my ($next, $self, @args) = @_;

    my @query = $next->($self, @args);

    push @query, (chtm => $self->area);
    if ($self->has_colors) {
        push @query, (chco => join(',', @{ $self->colors } ));
    }
    if ($self->has_codes) {
        push @query, (chld => join('', @{ $self->codes } ));
    }

    return @query;
};

__PACKAGE__->meta->make_immutable();

1;
