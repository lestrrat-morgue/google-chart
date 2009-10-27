
package Google::Chart::Type::SparkLine;
use Moose;
use namespace::clean -except => qw(meta);

with 'Google::Chart::Type';

sub as_query {
    my $self = shift;
    return (cht => 'ls');
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

Google::Chart::Type::SparkLine - Google::Chart SparkLine Type

=cut