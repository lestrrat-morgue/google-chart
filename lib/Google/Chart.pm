
package Google::Chart;
use Moose;
use Google::Chart::Axis;
use Google::Chart::Data;
use Google::Chart::Encoding::Extended;
use Google::Chart::Encoding::Simple;
use Google::Chart::Encoding::Text;
use Google::Chart::Grid;
use Google::Chart::Size;
use Google::Chart::Title;
use Google::Chart::Types;
use LWP::UserAgent;
use namespace::clean -except => qw(meta);

our $VERSION = '0.10000';

has axis => (
    is         => 'ro',
    isa        => 'Google::Chart::Axis',
    lazy_build => 1,
);

has axis_labels => (
    is       => 'ro',
    isa      => 'Google::Chart::Axis::Label',
    coerce   => 1
);

has color => (
    is       => 'ro',
    isa      => 'Google::Chart::Color',
    coerce   => 1,
);

has grid => (
    is       => 'ro',
    isa     => 'Google::Chart::Grid',
    coerce   => 1,
);

has size => (
    is       => 'ro',
    isa      => 'Google::Chart::Size',
    coerce   => 1,
    lazy_build => 1,
);

has title => (
    is        => 'ro',
    isa       => 'Google::Chart::Title',
    coerce    => 1,
    predicate => 'has_title',
);

has type => (
    init_arg => undef, # should NOT be initialized by callers
    is => 'ro',
    isa => 'Str',
    required => 1,
    lazy_build => 1,
);

has google_chart_uri => (
    is => 'ro',
    isa => 'URI',
    lazy_build => 1
);

has ua => (
    is         => 'rw',
    isa        => 'LWP::UserAgent',
    lazy_build => 1,
);

sub _build_axis {
    return Google::Chart::Axis->new();
}

sub add_axis {
    my $self = shift;
    $self->axis->add_axes( Google::Chart::Axis::Item->new(@_) );
}

sub _build_google_chart_uri {
    require URI;
    return $ENV{GOOGLE_CHART_URI} ? 
        URI->new($ENV{GOOGLE_CHART_URI}) :
        URI->new("http://chart.apis.google.com/chart");
}

sub _build_size {
    return Google::Chart::Size->new( width => 400, height => 200 );
}

sub _build_type { }

sub _build_ua {
    my $self = shift;
    my $ua = LWP::UserAgent->new(
        agent => "perl/Google-Chart-$VERSION",
        env_proxy => exists $ENV{GOOGLE_CHART_ENV_PROXY} ? $ENV{GOOGLE_CHART_ENV_PROXY} : 1,
    );
    return $ua;
}

sub create {
    my ($class, $chart_class, @args) = @_;

    if ($chart_class !~ s/^\+//) {
        $chart_class = "Google::Chart::Type::$chart_class";
    }

    if (! Class::MOP::is_class_loaded($chart_class) ) {
        Class::MOP::load_class($chart_class);
    }

    return $chart_class->new(@args);
}

sub prepare_query {
    my $self = shift;

    my %query = (
        cht => $self->type
    );

    foreach my $element (map { $self->$_() } qw(size title color axis axis_labels grid)) {
        next unless defined $element;
        my @params = $element->as_query( $self );
        while (@params) {
            my ($name, $value) = splice(@params, 0, 2);
            next unless length $value;
            $query{$name} = $value;
        }
    }

    return \%query;
}

sub as_uri {
    my $self = shift;

    # If in case you want to change this for debugging or whatever...
    my $uri = $self->google_chart_uri()->clone;
    $uri->query_form( $self->prepare_query() );
    return $uri;
}

sub render {
    my $self = shift;
    my $response = $self->ua->get($self->as_uri);

    if ($response->is_success) {
        return $response->content;
    } else {
        die $response->status_line;
    }
}

sub render_to_file {
    # XXX - This is done like this because there was a document-implementation
    # mismatch. In the future, single argument form should be deprecated
    my $self = shift;
    my $filename = (@_ > 1) ? do {
        my %args = @_;
        $args{filename};
    }: $_[0];

    open my $fh, '>', $filename or die "can't open $filename for writing: $!\n";
    binmode($fh); # be nice to windows
    print $fh $self->render;
    close $fh or die "can't close $filename: $!\n";
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

Google::Chart - Interface to Google Charts API

=head1 SYNOPSIS

  use Google::Chart;

  my $chart = Google::Chart->create(
    Bar => (
      bar_space   => 20,
      bar_width   => 10,
      group_space => 5,
      orientation => 'horizontal'
      size        => "400x300",
      stacked     => 1, 
    )
  );
  $chart->add_axis(
    location => 'x',
    label => [ qw(foo bar baz) ],
  );
  $chart->add_dataset(
    color => 'FF0000',
    data => [ 1, 2, 3, 4, 5 ],
  );

  print $chart->as_uri, "\n"; # or simply print $chart, "\n"

  $chart->render_to_file( filename => 'filename.png' );

=head1 DESCRITPION

Google::Chart provides a Perl Interface to Google Charts API 
(http://code.google.com/apis/chart/).

Please note that version 0.10000 is a major rewrite, and has little to no
backwards compatibility.

=head1 METHODS

=head2 create( $chart_type => %args )

Creates a new chart of type $chart_type. The rest of the arguments are passed
to the constructor of the appropriate $chart_type class. Each chart type may
have a different set of attributes that it can initialize, but the following
are commong to all graphs:

=over 4

=item size

Specifies the chart size. Strings like "400x300", hash references, or already
instantiated objects can be used:

  my $chart = Google::Chart->new(
    size => "400x300",
  );

  my $chart = Google::Chart->new(
    size => {
      width => 400,
      height => 300
    }
  );

=item marker

Specifies the markers that go on line charts.

=item

=back

=head2 new(%args)

Creates a new Google::Chart instance. You should be using C<create> unless you're hacking on a new chart type.

=head2 as_uri()

Returns the URI that represents the chart object.

=head2 render()

Generates the chart image, and returns the contents.
This method internally uses LWP::UserAgent. If you want to customize LWP settings, create an instance of LWP::UserAgent and pass it in the constructor

    Google::Chart->new(
        ....,
        ua => LWP::UserAgent->new( %your_args )
    );

Proxy settings are automatically read via LWP::UserAgent->env_proxy(), unless you specify GOOGLE_CHART_ENV_PROXY environment variable to 0

=head2 render_to_file( %args )

Generates the chart, and writes the contents out to the file specified by
`filename' parameter

=head2 BASE_URI

The base URI for Google Chart

=head1 FEEDBACK

We don't believe that we fully utilize Google Chart's abilities. So there
might be things missing, things that should be changed for easier use.
If you find any such case, PLEASE LET US KNOW! Suggestions are welcome, but
code snippets, pseudocode, or even better, test cases, are most welcome.

=head1 TODO

=over 4

=item Standardize Interface

Objects need to expect data in a standard format. This is not the case yet.
(comments welcome)

=item Moose-ish Errors

I've been reported that some Moose-related errors occur on certain platforms.
I have not been able to reproduce it myself, so if you do, please let me
know.

=back

=head1 AUTHORS

Daisuke Maki C<< <daisuke@endeworks.jp> >> (current maintainer)

Nobuo Danjou C<< <nobuo.danjou@gmail.com> >>

Marcel Grünauer C<< <marcel@cpan.org> >> (original author)

=head1 LICENSE

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See http://www.perl.com/perl/misc/Artistic.html

=cut
