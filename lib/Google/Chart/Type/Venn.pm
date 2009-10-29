
package Google::Chart::Type::Venn;
use Moose;
use Moose::Util::TypeConstraints;
use namespace::clean -except => qw(meta);

extends 'Google::Chart';
with qw(
    Google::Chart::WithData
    Google::Chart::WithGrid
    Google::Chart::WithLinearGradientFill
    Google::Chart::WithLinearStripe
    Google::Chart::WithSolidFill
);

has legend => (
    is => 'ro',
    isa => 'ArrayRef',
);

has legend_position => (
    is => 'ro',
    isa => enum([ qw(b t r l) ]),
);

has colors => (
    is => 'ro',
    isa => 'ArrayRef',
);

sub _build_type { 'v' };

around prepare_query => sub {
    my ($next, $self, @args) = @_;
    my @query = $next->($self, @args);

    my $legends = $self->legend;
    if ($legends) {
        push @query, (chdl => join('|', @$legends));
    }

    my $position = $self->legend_position;
    if ($position) {
        push @query, (chdlp => $position);
    }

    my $colors = $self->colors;
    if ($colors) {
        push @query, (chco => join(',', @$colors));
    }

    return @query;
};

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME 

Google::Chart::Type::Venn - Google::Chart Venn Type

=cut