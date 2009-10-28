package Google::Chart::Marker;
use Moose;
use Moose::Util::TypeConstraints;
subtype 'Google::Chart::DataSet::MarkerType'
    => as 'Str'
    => where {
        /^(?:[acdosvVhx]|t[^,]+)/
    }
;

has type => (
    is => 'ro',
    isa => 'Google::Chart::DataSet::MarkerType',
);

has color => (
    is => 'ro',
    isa => 'Str',
);

has size => (
    is => 'ro',
    isa => 'Num',
);

has point => (
    is => 'ro',
    isa => 'Num',
);

has priority => (
    is => 'ro',
    isa => 'Num',
);

__PACKAGE__->meta->make_immutable();

1;
