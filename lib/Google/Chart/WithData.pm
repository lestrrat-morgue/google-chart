package Google::Chart::WithData;
use Moose::Role;
use namespace::clean -except => qw(meta);

# guess what, not all Chart types have datasets associated with it.
# so we make this a role

has data => (
    is       => 'ro',
    isa      => 'Google::Chart::Data',
    required => 1,
    lazy_build => 1,
);

sub _build_data {
    return Google::Chart::Data->new();
}

sub data_encoding {
    my $self = shift;
    my $encoding = shift;
    if (! blessed $encoding) {
        if ($encoding !~ s/^\+//) {
            $encoding = "Google::Chart::Encoding::$encoding";
        }
        if (! Class::MOP::is_class_loaded($encoding)) {
            Class::MOP::load_class($encoding);
        }
        $encoding = $encoding->new(@_);
    }
    $self->data->set_encoding($encoding);
}

around prepare_query => sub {
    my ($next, $self, @args) = @_;
    my @query = $next->( $self, @args );

    my @params = $self->data->as_query( $self );
    push @query, @params;
    return @query;
};

sub add_dataset {
    my $self = shift;
    $self->data->add_dataset(@_);
}

1;

__END__

=head1 NAME

Google::Chart::WithData - Role For Charts That Have "Plottable" Data

=head1 ATTRIBUTES

=head2 data

Google::Chart::Data instance.

=head1 METHODS

=head2 data_encoding( $class [, %args] )

Change the default encoding.

=head2 add_dataset( %dataset_args )

Adds a new data set

=cut
