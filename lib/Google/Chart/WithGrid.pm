
package Google::Chart::WithGrid;
use Moose::Role;
use namespace::clean -except => qw(meta);

has grids => (
    is => 'ro',
    isa => 'ArrayRef',
    lazy_build => 1,
);

sub _build_grids { [] }

# we have a list of grids, but only a set_grid -- why? because I'm anticipating
# changes like Google suddenly allowing multiple grids or something
sub set_grid {
    my ($self, @args) = @_;
    push @{ $self->grids },
        Google::Chart::Grid->new(@args);
}

around prepare_query => sub {
    my ($next, $self, @args) = @_;

    my @query = $next->($self, @args);
    my $grids = $self->grids;
    if (@$grids > 0) {
        my @chg;
        foreach my $grid (@$grids) {
            my @comps;
            $comps[0] = $grid->x_step_size if defined $grid->x_step_size;
            $comps[1] = $grid->y_step_size if defined $grid->y_step_size;
            $comps[2] = $grid->line_length if defined $grid->line_length;
            $comps[3] = $grid->blank_length if defined $grid->blank_length;
            push @chg, join(',', @comps);
        }
        push @query, (chg => join('|', @chg));
    }

    return @query;
};

package # hide from PAUSE
    Google::Chart::Grid;
use Moose;
use namespace::clean -except => qw(meta);

has x_step_size => (
    is => 'ro',
    isa => 'Num',
);

has y_step_size => (
    is => 'ro',
    isa => 'Num',
);

has line_length => (
    is => 'ro',
    isa => 'Num',
);

has blank_length => (
    is => 'ro',
    isa => 'Num',
);

__PACKAGE__->meta->make_immutable();

1;

__END__

=head1 NAME

Google::Chart::WithGrid - Charts With Grids

=head1 SYNOPSIS

    my $chart = Google::Chart->create( ... );
    $chart->set_grid(
        x_step_size  => $x_size,
        y_step_size  => $y_size,
        line_length  => $l_length,
        blank_length => $b_length,
    );

=head1 ATTRIBUTES

=head2 grids

Grid speficiation list.

=head1 METHODS

=head2 set_grid(%args)

Sets the grid spec.

=cut
