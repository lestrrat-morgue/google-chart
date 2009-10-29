
package Google::Chart::Data;
use Moose;
use Google::Chart::DataSet;
use Google::Chart::Encoding::Extended;
use Google::Chart::Encoding::Simple;
use Google::Chart::Encoding::Text;
use Google::Chart::Types;
use namespace::clean -except => qw(meta);

has datasets => (
    traits     => ['Array'],
    is         => 'ro',
    isa        => 'ArrayRef[Google::Chart::DataSet]',
    lazy_build => 1,
    handles    => {
        add_dataset    => 'push',
        dataset_count  => 'count',
        get_dataset_at => 'get',
    }
);

has encoding => (
    is => 'ro',
    does => 'Google::Chart::Encoding',
    lazy_build => 1,
    writer => 'set_encoding'
);

sub _build_datasets { [] }
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

sub prepare_query {
    my ($self, $chart) = @_;

    # Data delimiter *DIFFERS* between chart types (can you believe it?)
    my $data;
    my $encoding = $self->encoding;
    if ( $encoding->isa('Google::Chart::Encoding::Text') && 
         $chart->isa('Google::Chart::Type::Pie') ) {
        $data = $encoding->encode( $self->datasets, ',' );
    } else {
        $data = $encoding->encode( $self->datasets );
    }

    my @query = (chd => $data);
    my (@chco, @chdl, @chds);

    my $datasets =  $self->datasets;
    my $max = $self->dataset_count - 1;
    my $is_text_encoding = $encoding->isa('Google::Chart::Encoding::Text');
    for my $i (0..$max) {
        my $dataset = $datasets->[$i];
        if ($dataset->has_legend) {
            $chdl[$i] = $dataset->legend;
        }
        if ($dataset->has_color) {
            $chco[$i] = $dataset->color;
        }
        if ($dataset->has_min_value || $dataset->has_max_value) {
            $chds[$i] = join(',', $dataset->min_value, $dataset->max_value);
        }
    }
    if (@chds > 0) {
        push @query, (chds => join(",", map { defined $_ ? $_ : "," } @chds));
    }

    if (@chdl) {
        push @query, (chdl => join('|', map { defined $_ ? $_ : '' } @chdl));
    }
    if (@chco) {
        push @query, (chco => join(',', map { defined $_ ? $_ : '' } @chco));
    }
    return @query;
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
