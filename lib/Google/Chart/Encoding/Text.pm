package Google::Chart::Encoding::Text;
use Moose;
use Scalar::Util qw(looks_like_number);
use namespace::clean -except => qw(meta);

with 'Google::Chart::Encoding';

has strict => (
    is => 'ro',
    isa => 'Bool',
    default => 0,
);

sub encode {
    my ($self, $sets, $delim) = @_;

    if ($self->strict) {
        foreach my $set (@$sets) {
            foreach my $value (@$set) {
                if ( ($value < 0 || $value > 100) && $value != -1 ) {
                    confess 'Values for text encoding MUST BE values between 0 and 100, or the value -1';
                }
            }
        }
    }

    return 't:' . join( $delim || '|', # join data sets
        map {
            my $set = $_;
            join(',', 
                map { 
                    defined $_ && looks_like_number($_) ? 
                        $_ == -1 ? -1 :
                        sprintf("%0.1f", $_) : -1
                } @{$set->data}
            ) # join data values
        } @$sets
    );
}

__PACKAGE__->meta->make_immutable();

1;

__END__

=head1 NAME

Google::Chart::Encoding::Text - Text Encoding

=head1 DESCRIPTION

This is not to be confused with character encoding. This just means you can directly specify floating numbers (1 fractional digit) from 0.0 to 100.0.

We encode C<undef> as -1. You can specify either to denote a missing value.

=cut