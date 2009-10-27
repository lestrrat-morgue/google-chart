
package Google::Chart::Data;
use Moose;
use Google::Chart::DataSet;
use Google::Chart::Encoding::Extended;
use Google::Chart::Encoding::Simple;
use Google::Chart::Encoding::Text;
use Google::Chart::Types;
use namespace::clean -except => qw(meta);

with 'Google::Chart::QueryComponent';

has dataset => (
    is         => 'ro',
    isa        => 'ArrayRef[Google::Chart::DataSet]',
    lazy_build => 1,
);

has dataset_class => (
    is => 'ro',
    isa => 'Str',
    required => 1,
    lazy_build => 1,
);

has encoding => (
    is => 'ro',
    does => 'Google::Chart::Encoding',
    lazy_build => 1,
    writer => 'set_encoding'
);

sub _build_dataset { [] }
sub _build_dataset_class { 'Google::Chart::DataSet' }
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
        chd => $self->encoding->encode( $self->dataset ),
    );

    my @colors;
    my @legends;
    my $dataset = $self->dataset;
    for my $i (0..$#{$dataset}) {
        my $set = $dataset->[$i];
        if ($set->has_legend) {
            $legends[$i] = $set->legend;
        }
        if ($set->has_color) {
            $colors[$i] = $set->color;
        }
    }

    if (@legends) {
        $args{chdl} = join('|', map { defined $_ ? $_ : '' } @legends);
    }
    if (@colors) {
        $args{chco} = join(',', map { defined $_ ? $_ : '' } @colors);
    }
    return %args;
}

sub add_dataset {
    my $self = shift;

    my $class = $self->dataset_class;
    if (! Class::MOP::is_class_loaded($class) ) {
        Class::MOP::load_class($class);
    }

    push @{ $self->dataset }, $class->new(@_);
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
