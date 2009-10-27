
package Google::Chart::Data::Text;
use Moose;
use namespace::clean -except => qw(meta);

extends 'Google::Chart::Data';

has '+data' => (
    isa => 'ArrayRef[Google::Chart::Data::Text::DataSet]',
);

sub BUILDARGS {
    my $self = shift;

    # A dataset must be an array of arrays or array of values
    my @dataset;
    my @dataargs;
    my %args;

    if (@_ == 1 && ref $_[0] eq 'ARRAY') {
        @dataargs = @{$_[0]};
    } else {
        %args = @_;
        @dataargs = @{ delete $args{data} || [] };
    }

    if (! ref $dataargs[0] ) {
        @dataargs = ([ @dataargs]);
    }

    foreach my $dataset ( @dataargs ) {
        if (! Scalar::Util::blessed $dataset) {
            $dataset = Google::Chart::Data::Text::DataSet->new(data => $dataset)
        }
        push @dataset, $dataset;
    }

    return { %args, data => \@dataset }
}

sub parameter_value {
    my $self = shift;
    sprintf('t:%s',
        join( '|', map { $_->as_string } @{ $self->dataset } ) )
}

__PACKAGE__->meta->make_immutable;

package  # hide from PAUSE
    Google::Chart::Data::Text::DataSet;
use Moose;
use Moose::Util::TypeConstraints;
use namespace::clean -except => qw(meta);

subtype 'Google::Chart::Data::Text::DataSet::Value'
    => as 'Num'
    => where {
        ($_ >= 0 && $_ <= 100) || $_ == -1
    }
;

has 'data' => (
    is => 'rw',
    isa => 'ArrayRef[Maybe[Google::Chart::Data::Text::DataSet::Value]]',
    required => 1,
    default => sub { +[] }
);

sub as_string {
    my $self = shift;
    return join(',', map { sprintf('%0.1f', $_) } @{$self->data});
}

__PACKAGE__->meta->make_immutable;
    
1;

__END__

=head1 NAME

Google::Chart::Data::Text - Google::Chart Text Encoding

=head1 SYNOPSIS

  Google::Chart->new(
    data => {
      type => "Text",
      dataset => [ .... ]
    }
  );

=head1 METHODS

=head2 parameter_value

=cut