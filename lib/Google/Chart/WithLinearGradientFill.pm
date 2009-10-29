package Google::Chart::WithLinearGradientFill;
use Moose::Role;
use namespace::clean -except => qw(meta);

# Current spec doesn't allow for multiple gradient fills, but 
# who knows... so making this a separate object so we can just change this
# from 'Object' to 'ArrayRef[Object]'
has linear_gradient_fill => (
    is => 'ro',
    isa => 'Google::Chart::LinearGradientFill',
    writer => '_set_linear_gradient_fill',
);


sub add_linear_gradient_fill {
    my ($self, @args) = @_;

    $self->_set_linear_gradient_fill(Google::Chart::LinearGradientFill->new(@args));
}

around prepare_query => sub {
    my ($next, $self, @args) = @_;
    my @query = $next->($self, @args);

    my $fill = $self->linear_gradient_fill;
    if ($fill) {
        push @query, (chf => 
            join(',', $fill->type, 'lg', $fill->angle, 
                join(',', @{$fill->colors})
            )
        );
    }

    return @query;
};

package #
    Google::Chart::LinearGradientFill;
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
