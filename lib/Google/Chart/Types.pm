
package Google::Chart::Types;
use Moose ();
use Moose::Util::TypeConstraints;
use Carp qw(carp confess);
use namespace::clean -except => qw(meta);

{
    enum 'Google::Chart::Axis::Position' => qw(x y r t);

    class_type 'Google::Chart::Axis';
    coerce 'Google::Chart::Axis'
        => from 'ArrayRef'
        => via {
            if (! Class::MOP::is_class_loaded('Google::Chart::Axis')) {
                Class::MOP::load_class('Google::Chart::Axis');
            }
            return Google::Chart::Axis->new(axes => $_)
        }
    ;

    class_type 'Google::Chart::Axis::Label';
    coerce 'Google::Chart::Axis::Label'
        => from 'ArrayRef'
        => via {
            my $arg = $_;
            if (! Class::MOP::is_class_loaded('Google::Chart::Axis::Label')) {
                Class::MOP::load_class('Google::Chart::Axis::Label');
            }

            # check if all elements are non-ref
            if (grep { ref $_ } @$arg) {
                return Google::Chart::Axis::Label->new(labels => $arg);
            } else {
                return Google::Chart::Axis::Label->new(labels => [$arg]);
            }
        }
    ;

    subtype 'Google::Chart::Data::Set'
        => as 'ArrayRef[ArrayRef]'
        => message { "Data set must be an arrayref of arrayrefs" }
    ;

    coerce 'Google::Chart::Data::Set',
        => from 'ArrayRef',
        => via {
            return [ $_ ]
        }
    ;

    subtype 'Google::Chart::Color::Data'
        => as 'Str'
        => where { /^[a-f0-9]{6}$/i }
        => message { "value '$_' is not a valid hexadecimal value" }
    ;

    class_type 'Google::Chart::Color';
    coerce 'Google::Chart::Color'
        => from 'Str'
        => via {
            if (! Class::MOP::is_class_loaded('Google::Chart::Color')) {
                Class::MOP::load_class('Google::Chart::Color');
            }
            Google::Chart::Color->new(values => [ $_ ])
        }
    ;
    coerce 'Google::Chart::Color'
        => from 'ArrayRef[Str]'
        => via {
            if (! Class::MOP::is_class_loaded('Google::Chart::Color')) {
                Class::MOP::load_class('Google::Chart::Color');
            }
            Google::Chart::Color->new(values => $_)
        }
    ;
}

{ # These are the most simplistic coercions
    class_type 'Google::Chart::Size';
    coerce 'Google::Chart::Size'
        => from 'Str'
        => via {
            if (! /^(\d+)x(\d+)$/) {
                confess("Could not parse $_ as size");
            }

            return Google::Chart::Size->new(width => $1, height => $2);
        }
    ;

    coerce 'Google::Chart::Size'
        => from 'HashRef'
        => via { 
            my $h = $_;
    
            my ($width, $height) = ($h->{args}) ?
                ($h->{args}->{width}, $h->{args}->{height}) :
                ($h->{width}, $h->{height})
            ;

            return Google::Chart::Size->new( width => $width, height => $height );
        }
    ;

    class_type 'Google::Chart::Data';
    coerce 'Google::Chart::Data'
        => from 'ArrayRef'
        => via  {
            return Google::Chart::Data->new(data => $_);
        }
    ;

    class_type 'Google::Chart::Size';
    coerce 'Google::Chart::Size'
        => from 'Str'
        => via  {
            my %args;
            @args{ qw(width height) } = split /x/, $_;
            return Google::Chart::Size->new(%args);
        }
    ;

    class_type 'Google::Chart::Title';
    coerce 'Google::Chart::Title'
        => from 'Str'
        => via {
            return Google::Chart::Title->new(text => $_);
        }
    ;

    role_type 'Google::Chart::Type';
    coerce 'Google::Chart::Type'
        => from 'Str'
        => via {
            my $class = $_;
            if ($class !~ s/^\+//) {
                $class = "Google::Chart::Type::$class";
            }

            if (! Class::MOP::is_class_loaded($class)) {
                Class::MOP::load_class($class);
            }
            return $class->new();
        }
    ;
    coerce 'Google::Chart::Type'
        => from 'HashRef'
        => via {
            my $h = $_;

            carp("This form of coercion (from Hash to Object) is now deprecated.");
            my $module = $h->{module} ||
                confess("No module name provided for coercion");
            if ($module !~ s/^\+//) {
                $module = "Google::Chart::Type::$module";
            }
            Class::MOP::load_class( $module );
            return $module->new(%{ $h->{args} });
        }
    ;

    coerce 'Google::Chart::Type'
        => from 'ArrayRef'
        => via {
            my ($class, %args) = @$_;
            if ($class !~ s/^\+//) {
                $class = "Google::Chart::Type::$class";
            }

            if (! Class::MOP::is_class_loaded($class)) {
                Class::MOP::load_class($class);
            }
            return $class->new(%args);
        }
    ;

    role_type 'Google::Chart::Encoding';
    coerce 'Google::Chart::Encoding'
        => from 'Str'
        => via {
            my $class = $_;
            if ($class !~ s/^\+//) {
                $class = "Google::Chart::Encoding::$class";
            }

            if (! Class::MOP::is_class_loaded($class)) {
                Class::MOP::load_class($class);
            }
            return $class->new();
        }
    ;
}

1;

__END__
use strict;
use warnings;
use Carp ();
use Moose::Util::TypeConstraints;
use Sub::Exporter -setup => {
    exports => [ qw(hash_coercion) ]
};

sub hash_coercion {
    my (%args) = @_;

    my $default = $args{default};
    my $prefix  = $args{prefix};

    return sub {
        my $h = $_;
        my $module = $h->{module} || $default ||
            Carp::confess("No module name provided for coercion");
        if ($module !~ s/^\+//) {
            $module = join('::', $prefix, $module);
        }
        Class::MOP::load_class( $module );
        return $module->new(%{ $h->{args} });
    }
}

{
    role_type 'Google::Chart::Type';
    coerce 'Google::Chart::Type'
        => from 'Str'
        => via {
            my $class = sprintf( 'Google::Chart::Type::%s', ucfirst $_ );
            Class::MOP::load_class($class);

            return $class->new();
        }
    ;
    coerce 'Google::Chart::Type'
        => from 'HashRef'
        => hash_coercion(prefix => "Google::Chart::Type")
    ;
}

{
    role_type 'Google::Chart::Fill';
    coerce 'Google::Chart::Fill'
        => from 'Str'
        => via {
            my $class = sprintf( 'Google::Chart::Fill::%s', ucfirst $_ );
            Class::MOP::load_class($class);

            return $class->new();
        }
    ;
    coerce 'Google::Chart::Fill'
        => from 'HashRef'
        => hash_coercion(prefix => "Google::Chart::Fill")
    ;
}

{
    role_type 'Google::Chart::Data';
    coerce 'Google::Chart::Data'
        => from 'ArrayRef'
        => via {
            my $class = 'Google::Chart::Data::Text';
            Class::MOP::load_class($class);
            $class->new(dataset => $_);
        }
    ;
    coerce 'Google::Chart::Data'
        => from 'HashRef'
        => via {
            my $class = $_->{module};
            if ($class !~ s/^\+//) {
                $class = "Google::Chart::Data::$class";
            }
            Class::MOP::load_class($class);

            $class->new(%{$_->{args}});
        }
    ;
}


1;

__END__

=head1 NAME

Google::Chart::Types - Google::Chart Miscellaneous Types

=head1 FUNCTIONS

=head2 hash_coercion

=cut
