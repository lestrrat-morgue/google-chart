
package Google::Chart::Encoding::Extended;
use Moose;
use Scalar::Util qw(looks_like_number);
use namespace::clean -except => qw(meta);

with 'Google::Chart::Encoding';

has 'max_value' => (
    is => 'rw', 
    isa => 'Num',
    required => 1,
);

has 'min_value' => (
    is => 'rw', 
    isa => 'Num',
    required => 1,
    default => 0,
);

my @map = ('A'..'Z', 'a'..'z', 0..9, '-', '.');
my $map_size = scalar @map;

sub encode {
    my ($self, $sets) = @_;

    my $max = $self->max_value;
    my $min = $self->min_value;

    my $scale    = $map_size ** 2  - 1;
    my $result = 'e:' . join(',', map {
        join( '',
            map {
                my $data = $_;
                my $v = '__';
#               if (defined $data && looks_like_number($data)) {
                    my $normalized = int((($data - $min) * $scale) / abs($max - $min));
                    if ($normalized < 0) {
                        $normalized = 0;
                    } elsif ($normalized >= $scale) {
                        $normalized = $scale - 1;
                    }

                    $v = $map[ int($normalized / $map_size)  ] . $map[ int($normalized % $map_size) ];
#               }
                $v;
            } @$_
        )
        } @$sets
    );
    return $result;
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

Google::Chart::Encoding::Extended - Google::Chart Extended Encoding

=head1 SYNOPSIS

=head1 METHODS

=head2 parameter_value

=cut
