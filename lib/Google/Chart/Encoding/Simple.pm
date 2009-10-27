package Google::Chart::Encoding::Simple;
use Moose;
use namespace::clean -except => qw(meta);

with 'Google::Chart::Encoding';

my @ENCODE_VALUES = ('A'..'Z', 'a'..'z', 0..9);
sub encode {
    my ($self, $sets) = @_;

    return 's:' . join( ',', # join data sets
        map {
            join('', map { defined $_ ? $ENCODE_VALUES[$_] : '_' } @$_) # join data values
        } @$sets
    );
    
}

1;

__END__

=head1 NAME

Google::Chart::Encoding::Simple - Encode Values Based On "Simple Encoding"

=cut
