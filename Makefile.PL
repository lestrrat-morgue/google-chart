use strict;
use inc::Module::Install;

name 'Google-Chart';

all_from('lib/Google/Chart.pm');

requires 'LWP::UserAgent';
requires 'Moose', '0.54';
requires 'Class::MOP', '0.63';
requires 'URI';
requires 'URI::Escape';
requires 'Scalar::Util';

test_requires 'Test::More';
test_requires 'Test::Compile';

auto_include;
WriteAll;
