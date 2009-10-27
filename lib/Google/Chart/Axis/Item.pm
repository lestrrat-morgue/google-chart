
package Google::Chart::Axis::Item;
use Moose;
use Moose::Util::TypeConstraints;
use Google::Chart::Axis::Style;
use namespace::clean -except => qw(meta);

enum 'Google::Chart::Axis::Location' => qw(x y r t);

has location => (
    is => 'rw',
    isa => 'Google::Chart::Axis::Location',
);

has labels => (
    is => 'rw',
    isa => 'ArrayRef[Str|Undef]',
    auto_deref => 1,
);

has label_positions => (
    is => 'rw',
    isa => 'ArrayRef[Num]',
    auto_deref => 1,
);

has range => (
    is => 'rw',
    isa => 'ArrayRef[Num]', # XXX should validate @range == 2
    auto_deref => 1,
);

has style => (
    is => 'rw',
    isa => 'Google::Chart::Axis::Style',
);

__PACKAGE__->meta->make_immutable;


1;

__END__

=head1 NAME

Google::Chart::Axis::Item - Google::Chart Axis Item

=cut
