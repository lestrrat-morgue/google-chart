package Google::Chart::WithRangeFill;
use Moose::Role;
use namespace::clean -except => qw(meta);

has range_fills => (
    is => 'ro',
    isa => 'ArrayRef[Google::Chart::RangeFill]',
    lazy_build => 1,
);

sub _build_range_fills { [] }

sub add_range_fill {
    my ($self, @args) = @_;

    push @{ $self->range_fills }, Google::Chart::RangeFill->new(@args);
}

around prepare_query => sub {
    my ($next, $self, @args) = @_;

    my @query = $next->($self, @args);

    my $fills = $self->range_fills;
    my @chm;
    foreach my $fill (@$fills) {
        push @chm, join(',', $fill->type, $fill->color, $fill->start_index, $fill->end_index, 5);
    }
    if (@chm) {
        push @query, (chm => join('|', @chm));
    }
    return @query;
};

package # hide from PAUSE
    Google::Chart::RangeFill;
use Moose;
use Moose::Util::TypeConstraints;
use namespace::clean -except => qw(meta);

has type => (
    is => 'ro',
    isa => enum([ qw(b B) ]),
    required => 1,
    default => 'b'
);

has color => (
    is => 'ro',
    isa => 'Str',
    required => 1
);

has start_index => (
    is => 'ro',
    isa => 'Int',
    required => 1,
    default => 0,
);

has end_index => (
    is => 'ro',
    isa => 'Int',
    required => 1,
);

1;
