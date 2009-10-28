package Google::Chart::WithMarker;
use Moose::Role;
use Google::Chart::Data::WithMarker;
use namespace::clean -except => qw(meta);

# We apply a marker trait
around _build_data => sub {
    my ($next, $self) = @_;
    my $data = $next->($self);
    Google::Chart::Data::WithMarker->meta->apply( $data );
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

1;