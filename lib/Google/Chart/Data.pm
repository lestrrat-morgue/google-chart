
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
    isa      => 'ArrayRef[ArrayRef]',
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

around BUILDARGS => sub {
    my $next = shift;
    my $class = shift;

    # A dataset must be an array of arrays or array of values
    my @dataset;
    my %args;

    if (@_ == 1 && ref $_[0] eq 'ARRAY') {
        @dataset = @{$_[0]};
    } else {
        %args = @_;
        @dataset = @{ delete $args{data} || [] };
    }

    if (! ref $dataset[0] ) {
        @dataset = ([ @dataset]);
    }

    my $args =  $class->$next( %args, data => \@dataset );
    return $args;
};

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

=head1 SYNOPSIS

    use Google::Chart::Data;

    Google::Chart::Data->new(
        encoding => Google::Chart::Encoding::Text->new(),
        data => [ 1.0, 2.0, undef, 50.0, -1, 100.0 ]
    );

=cut
