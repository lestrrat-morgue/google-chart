package Google::Chart::WithLineStyle;
use Moose::Role;
use namespace::clean -except => qw(meta);

around _build_dataset_traits => sub {
    my ($next, $self) = @_;
    my $traits = $next->($self);
    push @$traits, 'Google::Chart::DataSet::WithLineStyle';
    return $traits;
};

around prepare_query => sub {
    my ($next, $self, @args) = @_;

    my @query = $next->($self, @args);

    my @chls;
    my $datasets = $self->get_datasets;
    my $max = $#$datasets;
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

__END__

=head1 NAME

Google::Chart::WithLineStyle - Adds Line Style Properties To Your Dataset

=head1 SYNOPSIS

    my $chart = Google::Chart->create( ... );
    $chart->add_dataset(
        line_thickness       => $thickness,
        line_segment_length  => $ls_length,
        blank_segment_length => $bs_length,
        # rest of your options...
    );

=cut
