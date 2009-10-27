
package Google::Chart::Type::Bar;
use Moose;
use Moose::Util::TypeConstraints;
use namespace::clean -except => qw(meta);

extends 'Google::Chart';
with 'Google::Chart::WithData';

enum 'Google::Chart::Type::Bar::Orientation' => qw(horizontal vertical);

has bar_space => (
    is => 'ro',
    isa => 'Int',
    predicate => 'has_bar_space',
);

has bar_width => (
    is => 'ro',
    isa => 'Int',
    predicate => 'has_bar_width',
);

has group_space => (
    is => 'ro',
    isa => 'Int',
    predicate => 'has_group_space',
);
    
has orientation => (
    is      => 'ro',
    isa     => 'Google::Chart::Type::Bar::Orientation',
    default => 'vertical',
);

has stacked => (
    is       => 'ro',
    isa      => 'Bool',
    default  => 1,
);

sub _build_type {
    my $self = shift;
    
    return sprintf( 'b%s%s', 
        $self->orientation eq 'vertical' ? 'v' : 'h',
        $self->stacked                   ? 's' : 'g'
    );
}

around prepare_query => sub {
    my ($next, $self, @args) = @_;

    my $query = $next->($self, @args);
    if ($self->has_bar_width || $self->has_bar_space || $self->has_group_space) {
        $query->{ chbh } = join(',', 
            $self->bar_width || '',
            $self->bar_space || '',
            $self->group_space || '',
        );
    }
    return $query;
};

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

Google::Chart::Type::Bar - Google::Chart Bar Type

=head1 SYNOPSIS

  Google::Chart::Bar->new(
     stacked     => 1,
     orientation => "horizontal",
  );

=cut