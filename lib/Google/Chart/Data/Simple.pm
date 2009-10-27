
package Google::Chart::Data::Simple;
use Moose;
use Scalar::Util qw(looks_like_number);
use namespace::clean -except => qw(meta);

extends 'Google::Chart::Data';

my @map = ('A'..'Z', 'a'..'z', 0..9);

sub parameter_value {
    my $self = shift;
    my $max  = $self->max_value;
    my $size = @map - 1;

    my $result = '';
    foreach my $data ($self->data) {
        my $v = '_';
        if (defined $data && looks_like_number($data)) {
            my $index = int($data / $max * $size);

            if ($index < 0) {
                $index = 0;
            } elsif ($index > @map) {
                $index = $size;
            }
            $v = $map[$index];
        }

        $result .= $v;
    }
    return $result;
}

__PACKAGE__->meta->make_immutable;

package  # hide from PAUSE
    Google::Chart::Data::Simple::DataSet;
use Moose;
use Moose::Util::TypeConstraints;
use namespace::clean -except => qw(meta);

subtype 'Google::Chart::Data::Simple::DataSet::Value'
    => as 'Num'
    => where {
        /^[A-Za-z0-9\-\.]{2}$/
    }
;

has 'data' => (
    is => 'rw',
    isa => 'ArrayRef[Maybe[Google::Chart::Data::Simple::DataSet::Value]]',
    required => 1,
    default => sub { +[] }
);

sub as_string {
    my $self = shift;
    return join(',', @{$self->data});
}

__PACKAGE__->meta->make_immutable;
    
1;

__END__

=head1 NAME

Google::Chart::Data::Simple - Google::Chart Simple Data Encoding

=head1 SYNOPSIS

=head1 METHODS

=head2 parameter_value

=cut