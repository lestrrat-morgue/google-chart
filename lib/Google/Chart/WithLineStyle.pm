package Google::Chart::WithLineStyle;
use Moose::Role;
use namespace::clean -except => qw(meta);

around _build_data_traits => sub {
    my ($next, $self) = @_;
    my $traits = $next->($self);
    push @$traits, 'Google::Chart::Data::WithLineStyle';
    return $traits;
};

around prepare_query => sub {
    my ($next, $self, @args) = @_;

    my @query = $next->($self, @args);

    my @chls;
    my $datasets = $self->data->dataset;
    my $max = $self->data->dataset_count - 1;
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
        push @query, (chls => join('|', @chls));
    }
    return @query;
};

package # hide from PAUSE
    Google::Chart::Data::WithLineStyle;
use Moose::Role;
use namespace::clean -except => qw(meta);

around _build_dataset_traits => sub {
    my ($next, $self) = @_;
    my $traits = $next->($self);
    push @$traits, 'Google::Chart::DataSet::WithLineStyle';
    return $traits;
};

package # hide from PAUSE
    Google::Chart::DataSet::WithLineStyle;
use Moose::Role;
use namespace::clean -except => qw(meta);

has line_thickness => (
    is => 'ro',
    isa => 'Num',
    predicate => 'has_line_thickness',
);

has line_segment_length => (
    is => 'ro',
    isa => 'Num',
    predicate => 'has_line_segment_length',
);

has blank_segment_length => (
    is => 'ro',
    isa => 'Num',
    predicate => 'has_blank_segment_length',
);

1;
