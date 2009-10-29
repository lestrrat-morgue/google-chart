package Google::Chart::WithLinearStripe;
use Moose::Role;
use namespace::clean -except => qw(meta);

# Current spec doesn't allow for multiple strips, but 
# who knows... so making this a separate object so we can just change this
# from 'Object' to 'ArrayRef[Object]'
has linear_stripe => (
    is => 'ro',
    isa => 'Google::Chart::LinearStripe',
    writer => '_set_linear_stripe',
);


sub add_linear_stripe {
    my ($self, @args) = @_;

    $self->_set_linear_stripe(Google::Chart::LinearStripe->new(@args));
}

around prepare_query => sub {
    my ($next, $self, @args) = @_;
    my @query = $next->($self, @args);

    my $fill = $self->linear_stripe;
    if ($fill) {
        push @query, (chf => 
            join(',', $fill->type, 'ls', $fill->angle, 
                join(',', @{$fill->colors})
            )
        );
    }

    return @query;
};

package #
    Google::Chart::LinearStripe;
use Moose;
use Moose::Util::TypeConstraints;
use namespace::clean -except => qw(meta);

has type => (
    is => 'ro',
    isa => enum([ qw(c bg) ]),
    required => 1,
);

has angle => (
    is => 'ro',
    isa => 'Int',
    required => 1,
);

has colors => (
    is => 'ro',
    isa => 'ArrayRef',
    required => 1,
);

1;
