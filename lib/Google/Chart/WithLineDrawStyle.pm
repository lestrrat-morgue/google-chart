package Google::Chart::WithLineDrawStyle;
use Moose::Role;
use namespace::clean -except => qw(meta);

around _build_dataset_traits => sub {
    my ($next, $self, @args) = @_;
    my $traits = $next->($self, @args);

    push @$traits, 'Google::Chart::DataSet::LineDrawStyle';
    return $traits;
};

around prepare_query => sub {
    my ($next, $self, @args) = @_;
    my @query = $next->($self, @args);

    my $datasets = $self->get_datasets;
    my $max = $#$datasets;
    my @chm;
    for my $i (0..$max) {
        my $dataset = $datasets->[$i];
        if ($dataset->has_point ||
            $dataset->has_size ||
            $dataset->has_priority ) {
            push @chm, join(',', 'D', $dataset->color, $i, $dataset->point, $dataset->size, $dataset->priority);
        }
    }

    if (@chm) {
        push @query, (chm => join('|', @chm));
    }

    return @query;
};

package # hide from PAUSE
    Google::Chart::DataSet::LineDrawStyle;
use Moose::Role;
use Moose::Util::TypeConstraints;
use namespace::clean -except => qw(meta);

has point => (
    is => 'ro',
    isa => 'Int',
    predicate => 'has_point',
);

has size => (
    is => 'ro',
    isa => 'Int',
    predicate => 'has_size',
);

has priority => (
    is => 'ro',
    isa => enum([ 1, 0, -1 ]),
    predicate => 'has_priority',
);

1;

__END__

=head1 NAME

Google::Chart::WithLineDrawStyle - Bad Naming For Extra Line Styles

=cut
