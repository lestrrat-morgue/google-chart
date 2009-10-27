
package Google::Chart::Type::QRcode;
use Moose;
use Moose::Util::TypeConstraints;
use Encode ();
use namespace::clean -except => qw(meta);

extends 'Google::Chart';

enum 'Google::Chart::Type::QRcode::Encoding' => qw(shift_jis utf-8 iso-8859-1);
enum 'Google::Chart::Type::QRcode::ECLevel' => qw(L M Q H);

coerce 'Google::Chart::Type::QRcode::Encoding'
    => from 'Str'
    => via {
        s/^Shift[-_]JIS$/shift_jis/;
        s/^UTF-?8$/utf-8/;
        return lc $_;
    }
;

has text => (
    is => 'rw',
    isa => 'Str',
    required => 1
);

has qrcode_encoding => (
    is => 'rw',
    isa => 'Google::Chart::Type::QRcode::Encoding',
    required => 1,
    default => 'utf-8',
    coerce => 1
);

has eclevel => (
    is => 'rw',
    isa => 'Google::Chart::Type::QRcode::ECLevel',
);

has margin => (
    is => 'rw',
    isa => 'Num'
);

sub _build_type { 'qr' }

override prepare_query => sub {
    my $self = shift;
    my $query = super();

    $query->{cht} = 'qr';
    $query->{chl} = Encode::is_utf8($self->text) ?
        Encode::decode_utf8($self->text) : $self->text;
    $query->{choe} = $self->qrcode_encoding;
    if ($self->eclevel || $self->margin ) {
        $query->{chld} =
            join( '|', $self->eclevel || '', $self->margin || '');
    }

    return $query;
};

__PACKAGE__->meta->make_immutable();

1;

__END__

=head1 NAME

Google::Chart::Type::QRcode - Google::Chart QRcode Type

=head1 METHODS

=head2 as_query

=cut