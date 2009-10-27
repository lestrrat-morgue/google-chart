package Google::Chart::Color;
use Moose;
use Google::Chart::Types;
use namespace::clean -except => qw(meta);

with 'Google::Chart::QueryComponent';

has values => (
    is => 'ro',
    isa => 'ArrayRef[Google::Chart::Color::Data]',
    required => 1,
);

sub as_query {
    my $self = shift;
    return ( chco => join(',', @{$self->values}) );
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

Google::Chart::Color - Google::Chart Color

=cut
