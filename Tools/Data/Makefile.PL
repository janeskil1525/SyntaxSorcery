use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  NAME         => 'Data::Load::Datasection',
  VERSION_FROM => 'lib/GenerateSQL::Tools::Datasections.pm',
  AUTHOR       => 'janskil1525@gmail.com',
  PREREQ_PM    => {'Mojo::Loader' => '9.38'},
  test         => {TESTS => 't/*.t'}
);
