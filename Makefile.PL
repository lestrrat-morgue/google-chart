use inc::Module::Install;
include 'Module::AutoInstall';

name 'Google-Chart';
all_from 'lib/Google/Chart.pm';
perl_version '5.006';

requires 'Class::Accessor::Complex';
requires 'Class::Accessor::Constructor';
requires 'Class::Accessor::FactoryTyped' => '0.03';
requires 'Class::Factory::Enhanced';
requires 'LWP::UserAgent';

build_requires 'Test::More' => '0.70';

process_templates(
    first_year => 2007,
    rest_from  => "$ENV{HOME}/.mitlib/standard_pod",
    start_tag  => '{%',
    end_tag    => '%}',
);

use_standard_tests(without => 'pod_coverage');
auto_install;
auto_include;
WriteAll;
