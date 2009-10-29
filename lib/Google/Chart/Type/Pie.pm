
package Google::Chart::Type::Pie;
use Moose;
use Moose::Util::TypeConstraints;
use namespace::clean -except => qw(meta);

extends 'Google::Chart';
with qw(
    Google::Chart::WithData 
    Google::Chart::WithGrid
    Google::Chart::WithSize
    Google::Chart::WithSolidFill
);

has pie_type => (
    is => 'ro',
    isa => enum([ qw(2d 3d) ]),
    required => 1,
    default => '2d'
);

has pie_labels => (
    traits => ['Array'],
    is => 'ro',
    isa => 'ArrayRef',
    lazy_build => 1,
    handles => {
        add_pie_label => 'push',
    }
);

sub _build_pie_labels { [] }

sub _build_type {
    my $self = shift;
    return $self->pie_type eq '3d' ? 'p3' : 'p';
}

around prepare_query => sub {
    my ($next, $self, @args) = @_;
    my @query = $next->($self, @args);

    my $labels = $self->pie_labels();
    if (@$labels > 0) {
        push @query, (chl => join('|', map { defined $_ ? $_ : '' } @$labels));
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