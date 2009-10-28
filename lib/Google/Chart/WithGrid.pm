
package Google::Chart::WithGrid;
use Moose::Role;
use Moose::Util::TypeConstraints;
use namespace::clean -except => qw(meta);

has _grid_enabled => (
    is => 'rw',
    isa => 'Bool',
    default => 0
);

has grid_x_step_size => (
    is => 'ro',
    isa => 'Num',
    trigger => sub { $_[0]->_grid_enabled(1) }
);

has grid_y_step_size => (
    is => 'ro',
    isa => 'Num',
    trigger => sub { $_[0]->_grid_enabled(1) }
);

has grid_line_length => (
    is => 'ro',
    isa => 'Num',
    trigger => sub { $_[0]->_grid_enabled(1) }
);

has grid_blank_length => (
    is => 'ro',
    isa => 'Num',
    trigger => sub { $_[0]->_grid_enabled(1) }
);

around prepare_query => sub {
    my ($next, $self, @args) = @_;

    my @query = $next->($self, @args);
    if ($self->_grid_enabled) {
        my @chg;
        $chg[0] = $self->grid_x_step_size if defined $self->grid_x_step_size;
        $chg[1] = $self->grid_y_step_size if defined $self->grid_y_step_size;
        $chg[2] = $self->grid_line_length if defined $self->grid_line_length;
        $chg[3] = $self->grid_blank_length if defined $self->grid_blank_length;
        push @query, (chg => join(',', @chg));
    }

    return @query;
};

1;

__END__

=head1 NAME

Google::Chart::Grid - Google::Chart Grid Specification 

=head1 METHODS

=head2 as_query

=cut
