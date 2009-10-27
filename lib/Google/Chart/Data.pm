
package Google::Chart::Data;
use Moose;
use Google::Chart::Types;
use Google::Chart::DataSet;
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
    isa      => 'ArrayRef[Google::Chart::DataSet]',
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

    foreach (@dataset) {
        if ( ! blessed $_ ) {
            $_ = Google::Chart::DataSet->new(data => $_);
        }
    }

    my $args = $class->$next( %args, data => \@dataset );
    return $args;
};

sub as_query {
    my $self = shift;

    my %args = (
        chd => $self->encoding->encode( $self->data ),
    );

    my @legends;
    my $do_legend = 0;
    foreach my $set (@{$self->data}) {
        if ($set->has_legend) {
            $do_legend++;
        }
        push @legends, $set->legend;
    }

    if ($do_legend) {
        $args{chdl} = join('|', map { defined $_ ? $_ : '' } @legends);
    }
    return %args;
}

__PACKAGE__->meta->make_immutable();

1;

__END__

=head1 NAME

Google::Chart::Data - Google::Chart Data

=head1 SYNOPSIS

    use Google::Chart::Data;

    # simple, text encoding
    Google::Chart::Data->new(
        [ 1.0, 2.0, undef, 50.0, -1, 100.0 ]
    );

    # Explicity encoding specification, with legend
    Google::Chart::Data->new(
        encoding => Google::Chart::Encoding::Extended->new(
            max_value => 150,
        ),
        data => [
            Google::Chart::DataSet->new(
                legend => "Data set 1",
                data   => [ 1.0, 2.0, undef, 50.0, -1, 100.0 ]
            ),
            Google::Chart::DataSet->new(
                legend => "Data set 2",
                data   => [ 1, 400, 500, 100]
            )
        ]
    );

=cut
