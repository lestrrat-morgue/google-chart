package Google::Chart::Data::LineType;
use Moose;
use Google::Chart::Data::LineType;
use namespace::clean -except => qw(meta);

extends 'Google::Chart::Data';

sub _build_dataset_class {
    return "Google::Chart::DataSet::LineType";
}

override as_query => sub {
    my $self = shift;
    my %query = super();

    my @chls;
    foreach my $dataset ( @{ $self->dataset } ) {
        if ($dataset->has_thickness || $dataset->has_line_segment_length || $dataset->has_blank_segment_length ) {
            push @chls, join(',',
                map { defined $_ ? $_ : '' }
                    $dataset->thickness,
                    $dataset->line_segment_length,
                    $dataset->blank_segment_length,
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
