package Google::Chart::WithMarker;
use Moose::Role;
use namespace::clean -except => qw(meta);

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

        if ( $dataset->has_marker_type ||
             $dataset->has_marker_color ||
             $dataset->has_marker_points ||
             $dataset->has_marker_size ||
             $dataset->has_marker_priority ) {
            $chm[$i] = join(',',
                $dataset->marker_type,
                $dataset->marker_color || '',
                $i,
                $dataset->marker_points || -1,
                $dataset->marker_size || '',
                $dataset->marker_priority || ''
            );
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

package # hide from PAUSE
    Google::Chart::DataSet::WithMarker;
use Moose::Role;
use Moose::Util::TypeConstraints;
use namespace::clean -except => qw(meta);

has marker_type => (
    is => 'ro',
    isa => enum([ qw(a c d o s t v V h x) ]),
    predicate => 'has_marker_type',
);

has marker_color => (
    is => 'ro',
    isa => 'Str',
    predicate => 'has_marker_color',
);

has marker_size => (
    is => 'ro',
    isa => 'Int',
    predicate => 'has_marker_size',
);

has marker_points => (
    is => 'ro',
    isa => 'ArrayRef',
    predicate => 'has_marker_points',
);

has marker_priority => (
    is => 'ro',
    isa => 'Int',
    predicate => 'has_marker_priority'
);

1;