package Google::Chart::Type::GoogleOMeter;
use Moose;
use namespace::clean -except => qw(meta);

extends 'Google::Chart';

with qw(
    Google::Chart::WithData
);

sub _build_type { 'gom' }

__PACKAGE__->meta->make_immutable();

1;
