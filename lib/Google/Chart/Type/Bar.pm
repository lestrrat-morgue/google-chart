
package Google::Chart::Type::Bar;
use Moose;
use Moose::Util::TypeConstraints;
use namespace::clean -except => qw(meta);

with 'Google::Chart::Type';

enum 'Google::Chart::Type::Bar::Orientation' => qw(horizontal vertical);

has stacked => (
    is       => 'ro',
    isa      => 'Bool',
    default  => 1,
);

has orientation => (
    is      => 'ro',
    isa     => 'Google::Chart::Type::Bar::Orientation',
    default => 'vertical',
);

has width => (
    is => 'ro',
    isa => 'Int',
    predicate => 'has_width',
);

has bar_space => (
    is => 'ro',
    isa => 'Int',
    predicate => 'has_bar_space',
);

has group_space => (
    is => 'ro',
    isa => 'Int',
    predicate => 'has_group_space',
);
    

sub as_query {
    my $self = shift;

    my %query = (
        cht => sprintf( 'b%s%s', 
            $self->orientation eq 'vertical' ? 'v' : 'h',
            $self->stacked                   ? 's' : 'g'
        )
    );
    if ($self->has_width || $self->has_bar_space || $self->has_group_space) {
        $query{ chbh } = join(',', 
            $self->width || '',
            $self->bar_space || '',
            $self->group_space || '',
        );
    }
    return %query;
}

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