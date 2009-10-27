
package Google::Chart::Axis;
use Moose;
use Google::Chart::Axis::Item;
use Google::Chart::Types;
use namespace::clean -except => qw(meta);

with 'Google::Chart::QueryComponent';

has axes => (
    is => 'ro',
    isa => 'ArrayRef[Google::Chart::Axis::Item]',
    required => 1,
);


sub as_query {
    my $self = shift;

    my $count = 0;
    my %query = (
        chxt => [],
        chxl => [],
        chxp => [],
        chxr => [],
        chxs => [],
    );
    foreach my $axis (@{ $self->axes }) {
        push @{$query{chxt}}, $axis->location;
        if (my @labels = $axis->labels) {
            push @{$query{chxl}}, join('|', "$count:", map { defined $_ ? $_ : '' } @labels);
        }
        if (my @label_positions = $axis->label_positions) {
            push @{$query{chxp}}, join(',', "$count:", @label_positions);
        }
        if (my @range = $axis->range) {
            push @{$query{chxr}}, join(',', "$count:", @range);
        }
        if (my $style = $axis->style) {
            push @{$query{chxs}}, join(',', $style->color, $style->font_size, $style->alignment);
        }
        $count++;
    }

    foreach my $comp qw( chxt ) {
        my $list = delete $query{ $comp };
        if (scalar @$list > 0) {
            $query{ $comp } = join(',', @$list);
        }
    }
        
    foreach my $comp qw( chxl chxp chxr chxs ) {
        my $list = delete $query{ $comp };
        if (scalar @$list > 0) {
            $query{ $comp } = join('|', @$list);
        }
    }

    return %query;
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

Google::Chart::Axis - Google::Chart Axis Specification 

=head1 METHODS

=head2 as_query

=cut
