
package Google::Chart::Type::Line;
use Moose;
use namespace::clean -except => qw(meta);

with 'Google::Chart::Type';

sub as_query {
    my $self = shift;
    return (cht => 'lc');
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

Google::Chart::Type::Line - Google::Chart Line Type

=cut