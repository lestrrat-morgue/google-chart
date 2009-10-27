
package Google::Chart::Type::Line;
use Moose;
use namespace::clean -except => qw(meta);

extends 'Google::Chart';

sub _build_type {
    return 'lc';
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

Google::Chart::Type::Line - Google::Chart Line Type

=cut