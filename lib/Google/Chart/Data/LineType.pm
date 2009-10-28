package Google::Chart::Data::LineType;
use Moose;
use Google::Chart::DataSet::LineType;
use namespace::clean -except => qw(meta);

extends 'Google::Chart::Data';

sub _build_dataset_class {
    return "Google::Chart::DataSet::LineType";
}

override as_query => sub {
    my $self = shift;
    my %query = super();

    my @chls;
    my $datasets = $self->dataset;
    my $max = $self->dataset_count - 1;
    for my $i (0..$max) {
        my $dataset = $datasets->[$i];
        if ($dataset->has_line_thickness || $dataset->has_line_segment_length || $dataset->has_blank_segment_length ) {
            $chls[$i] = join(',',
                map { defined $_ ? $_ : '' }
                    $dataset->line_thickness || 1,
                    $dataset->line_segment_length || 0,
                    $dataset->blank_segment_length || 0,
            );
        }
    }

    if (@chls) {
        $query{chls} = join('|', @chls);
    }
    return %query;
};

__PACKAGE__->meta->make_immutable();

1;
