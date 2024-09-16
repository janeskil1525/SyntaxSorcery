use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  NAME         => 'Data::Load::Datasection',
  VERSION_FROM => 'lib/GenerateSQL.pm',
  AUTHOR       => 'janskil1525@gmail.com',
  PREREQ_PM    => {
      'Syntax::Keyword::Match '  => '0.15',
      'Mojo::JSON'               => '9.38',
      'Data::Load::Datasections' => '0.01'
  },
  test         => {TESTS => 't/*.t'}
);
