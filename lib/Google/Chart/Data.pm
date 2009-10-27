
package Google::Chart::Data;
use Moose;
use Google::Chart::Types;
use namespace::clean -except => qw(meta);

with 'Google::Chart::QueryComponent';

has encoding => (
    is => 'ro',
    does => 'Google::Chart::Encoding',
    coerce => 1,
    lazy_build => 1
);

has data => (
    is       => 'ro',
    isa      => 'Google::Chart::Data::Set',
    coerce   => 1,
    required => 1,
);

sub _build_encoding {
    my $self = shift;
    if (! Class::MOP::is_class_loaded('Google::Chart::Encoding::Text')) {
        Class::MOP::load_class( 'Google::Chart::Encoding::Text' );
    }
    Google::Chart::Encoding::Text->new();
}

sub as_query {
    my $self = shift;

    return (
        chd => $self->encoding->encode( $self->data ),
    );
}

__PACKAGE__->meta->make_immutable();

1;

__END__

=head1 NAME

Google::Chart::Data - Google::Chart

=cut
