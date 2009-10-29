package Google::Chart::WithMarker;
use Moose::Role;
use namespace::clean -except => qw(meta);
with 'Google::Chart::WithData';

sub add_marker { shift->data->add_marker(@_) }

around _build_data_traits => sub {
    my ($next, $self) = @_;
    my $traits = $next->($self);
    push @$traits, 'Google::Chart::Data::WithMarker';
    return $traits;
};

around prepare_query => sub {
    my ($next, $self, @args) = @_;

    my @query = $next->($self, @args);

    my $datasets = $self->data->dataset;
    my $max = $self->data->dataset_count - 1;
    my @chm;
    for my $i (0..$max) {
        my $dataset = $datasets->[$i];

        if ( $dataset->has_markers ) {
            my $markers = $dataset->markers;
            foreach my $marker (@$markers) {
                push @chm, join(',',
                    $marker->type,
                    $marker->color || '',
                    $i,
                    !defined $marker->point ? -1 : $marker->point,
                    $marker->size || '',
                    $marker->priority || ''
                );
            }
        }
    }

    if (@chm) {
        push @query, ( chm => join('|', @chm) );
    }

    return @query;
};

package  # hide from PAUSE
    Google::Chart::Data::WithMarker;
use Moose::Role;
use namespace::clean -except => qw(meta);

around _build_dataset_traits => sub {
    my ($next, $self) = @_;

    my $traits = $next->($self);
    push @$traits, 'Google::Chart::DataSet::WithMarker';
    return $traits;
};

sub add_marker {
    my ($self, %args) = @_;

    my $dataset_index = delete $args{dataset_index} || 0;
    my $dataset = $self->dataset->[$dataset_index] or
        confess "dataset at index $dataset_index does NOT exist!";

    $dataset->add_marker(%args);
}

package # hide from PAUSE
    Google::Chart::DataSet::WithMarker;
use Moose::Role;
use namespace::clean -except => qw(meta);

has markers => (
    is => 'ro',
    isa => 'ArrayRef[Google::Chart::Marker]',
    lazy_build => 1,
    predicate => 'has_markers',
);

sub _build_markers { [] }

sub add_marker {
    my ($self, %args) = @_;

    my $marker = Google::Chart::Marker->new(%args);
    push @{ $self->markers }, $marker;
}

package # hide from PAUSE
    Google::Chart::Marker;
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


1;