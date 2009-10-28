
package Google::Chart::Type::Line;
use Moose;
use Google::Chart::Data::LineType;
use namespace::clean -except => qw(meta);

extends 'Google::Chart';
with qw(
    Google::Chart::WithAxis
    Google::Chart::WithData 
    Google::Chart::WithGrid
);

sub _build_data {
    return Google::Chart::Data::LineType->new();
}

sub _build_type {
    return 'lc';
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

Google::Chart::Type::Line - Google::Chart Line Type

=cut