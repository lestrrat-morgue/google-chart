
package Google::Chart::Type::Venn;
use Moose;
use namespace::clean -except => qw(meta);

extends 'Google::Chart';
with qw(
    Google::Chart::WithData 
    Google::Chart::WithGrid
    Google::Chart::WithLinearGradientFill
    Google::Chart::WithLinearStripe
    Google::Chart::WithSolidFill
);

sub _build_type { 'v' };

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME 

Google::Chart::Type::Venn - Google::Chart Venn Type

=cut