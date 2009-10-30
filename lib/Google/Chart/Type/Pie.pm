
package Google::Chart::Type::Pie;
use Moose;
use Moose::Util::TypeConstraints;
use namespace::clean -except => qw(meta);

extends 'Google::Chart';
with qw(
    Google::Chart::WithData 
    Google::Chart::WithGrid
    Google::Chart::WithSolidFill
);

# NOTE: exists in en version, but not in ja
has orientation => (
    is => 'ro',
    isa => 'Num',
);

# NOTE: pc does not exist in ja
has pie_type => ( # this *needs* the pie_ prefix cause it clashes
                  # with the parent class's type... but the rest shouldn't
    is => 'ro',
    isa => enum([ qw(2d 3d pc) ]),
    required => 1,
    default => '2d'
);

# This option begs the question: can it be in the dataset?
has labels => (
    traits => ['Array'],
    is => 'ro',
    isa => 'ArrayRef',
    lazy_build => 1,
    handles => {
        add_labels => 'push',
    }
);

sub _build_labels { [] }

sub _build_type {
    my $self = shift;
    return $self->pie_type eq '3d' ? 'p3' : 'p';
}

around prepare_query => sub {
    my ($next, $self, @args) = @_;
    my @query = $next->($self, @args);

    my $labels = $self->labels();
    if (@$labels > 0) {
        push @query, (chl => join('|', map { defined $_ ? $_ : '' } @$labels));
    }

    if ($self->orientation) {
        push @query, (chp => $self->orientation);
    }

    return @query;
};

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

Google::Chart::Type::Pie - Google::Chart Pie Chart Type

=head1 SYNOPSIS

  Google::Chart->new(
    type => 'Pie'
  );

  Google::Chart->new(
    type => {
      module => 'Pie',
      args   => {
        pie_type => '3d'
      }
    }
  );

=head1 METHODS

=head2 parameter_value

=cut