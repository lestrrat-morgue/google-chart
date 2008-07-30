# $Id$

package Google::Chart::Marker;
use Moose;
use Moose::Util::TypeConstraints;
use Google::Chart::Types;
use Google::Chart::Color;

use constant parameter_name => 'chm';

with 'Google::Chart::QueryComponent::Simple';

enum 'Google::Chart::Marker::Type' => (
    'a', # arrow
    'c', # corrs
    'd', # diamond
    'o', # circle
    's', # square
    't', # text
    'v', # vertical line from x-axis to the data point
    'V', # vertical line to the top of the chart
    'h', # horizontal line across
    'x', # x shape
);

has 'marker_type' => (
    is => 'rw',
    isa => 'Google::Chart::Marker::Type',
    required => 1,
    default => 'o'
);

has 'color' => (
    is => 'rw',
    isa => 'Google::Chart::Color::Data',
    required => 1,
    default => '000000',
);

has 'dataset' => (
    is => 'rw',
    isa => 'Int',
    required => 1,
    default => 0,
);

has 'datapoint' => (
    is => 'rw',
    isa => 'Num',
    required => 1,
    default => -1,
);

has 'size' => (
    is => 'rw',
    isa => 'Int',
    required => 1,
    default => 5,
);

has 'priority' => (
    is => 'rw',
    isa => 'Int',
    required => 1,
    default => 0,
);

no Moose;

sub parameter_value {
    my $self = shift;

    return join(',', 
        map { $self->$_ } qw(marker_type color dataset datapoint size priority) );
}

1;

__END__

=head1 NAME

Google::Chart::Marker - Google::Chart Marker

=head1 METHODS

=head2 parameter_value

=cut
