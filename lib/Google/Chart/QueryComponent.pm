
package Google::Chart::QueryComponent;
use Moose::Role;
use namespace::clean -except => qw(meta);

requires 'as_query';

1;

__END__

=head1 NAME

Google::Chart::QueryComponent - Google::Chart Query Component

=head1 SYNOPSIS

  package MyStuff;
  use Moose;
  with 'Google::Chart::QueryComponent';

  sub as_query { .... }

=head1 METHODS

=head2 as_query

Should return a list of key/value pair (i.e. hash, not a hash reference) that
can be fed to an URI object

=cut
