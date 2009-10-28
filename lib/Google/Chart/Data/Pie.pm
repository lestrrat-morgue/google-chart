package Google::Chart::Data::Pie;
use Moose;
use Google::Chart::DataSet::Pie;
use namespace::clean -except => qw(meta);

extends 'Google::Chart::Data';

sub _build_dataset_class {
    return "Google::Chart::DataSet::Pie";
}

override prepare_query => sub {
    my $self = shift;
    my @query = super();

    my @chl;
    my $datasets = $self->dataset;
    foreach my $i (0..($self->dataset_count - 1)) {
        my $dataset = $datasets->[$i];
        if ($dataset->has_label) {
            $chl[$i] = $dataset->label;
        }
    }

    if (@chl) {
        push @query, (chl => join('|', @chl));
    }
    return @query;
};

__PACKAGE__->meta->make_immutable();

1;
