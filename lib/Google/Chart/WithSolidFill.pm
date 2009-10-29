package Google::Chart::WithSolidFill;
use Moose::Role;
use namespace::clean -except => qw(meta);

has solid_fills => (
    is => 'ro',
    isa => 'ArrayRef',
    lazy_build => 1,
);

sub _build_solid_fills { [] }

sub add_solid_fill {
    my ($self, @args) = @_;
    push @{ $self->solid_fills }, 
        Google::Chart::SolidFill->new(@args);
}

around prepare_query => sub {
    my ($next, $self, @args) = @_;

    my @query = $next->($self, @args);
    my $solid_fills = $self->solid_fills;
    my @chf;
    if (@$solid_fills > 0) {
        foreach my $fill (@$solid_fills) {
            push @chf, join(',', $fill->type, 's', $fill->color);
        }

        push @query, (chf => join('|', @chf));
    }

    return @query;
};

package # hide from PAUSE
    Google::Chart::SolidFill;
use Moose;
use Moose::Util::TypeConstraints;
use namespace::clean -except => qw(meta);

has type => (
    is => 'ro',
    isa => enum([ qw(bg c a) ]),
    required => 1,
);

has color => (
    is => 'ro',
    isa => 'Str',
    required => 1,
);

__PACKAGE__->meta->make_immutable();

1;
