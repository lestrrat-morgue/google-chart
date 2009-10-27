
package Google::Chart::Type::SparkLine;
use Moose;
use Google::Chart::Data::LineType;
use namespace::clean -except => qw(meta);

extends 'Google::Chart';
with 'Google::Chart::WithData';

sub _build_data {
    return Google::Chart::Data::LineType->new();
}

sub _build_type { 'ls' }

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

Google::Chart::Type::SparkLine - Google::Chart SparkLine Type

=cut