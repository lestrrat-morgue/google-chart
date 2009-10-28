package Google::Chart::Type::GoogleOMeter;
use Moose;
use namespace::clean -except => qw(meta);

extends 'Google::Chart';

with qw(
    Google::Chart::WithData
);

has label => (
    is => 'ro',
    isa => 'Str',
    predicate => 'has_label'
);

has colors => (
    is => 'ro',
    isa => 'ArrayRef',
    lazy_build => 1,
);

sub _build_colors { [] }
sub _build_type { 'gom' }

around prepare_query => sub {
    my ($next, $self, @args) = @_;

    my @query = $next->($self, @args);
    if ($self->has_label) {
        push @query, (chl => $self->label);
    }

    my $colors = $self->colors;
    if (@$colors > 0) {
        push @query, (chco => join(',', @$colors));
    }
    return @query;
};

__PACKAGE__->meta->make_immutable();

1;
