package Google::Chart::Data::WithMarker;
use Moose::Role;
use Google::Chart::DataSet::WithMarker;
use namespace::clean -except => qw(meta);

around _build_dataset_traits => sub {
    my ($next, $self) = @_;

    my $traits = $next->($self);
    push @$traits, 'Google::Chart::DataSet::WithMarker';
    return $traits;
};

1;
