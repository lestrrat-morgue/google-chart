
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
    lazy => 1,
    default => 1,
    trigger => sub { $_[0]->_grid_enabled(1) }
);

has grid_blank_length => (
    is => 'ro',
    isa => 'Num',
    lazy => 1,
    default => 1,
    trigger => sub { $_[0]->_grid_enabled(1) }
);

around prepare_query => sub {
    my ($next, $self, @args) = @_;

    my $query = $next->($self, @args);
    if ($self->_grid_enabled) {
        $query->{chg} = join(',',
            map { $self->$_ || '' } qw(
                grid_x_step_size 
                grid_y_step_size 
                grid_line_length 
                grid_blank_length
            )
        );
    }

    return $query;
};

1;

__END__

=head1 NAME

Google::Chart::Grid - Google::Chart Grid Specification 

=head1 METHODS

=head2 as_query

=cut
