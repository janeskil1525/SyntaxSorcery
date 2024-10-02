use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  NAME         => 'Mojolicious::Plugin::UserCompany',
  VERSION_FROM => 'lib/Mojolicious/Plugin/UserCompany.pm',
  AUTHOR       => 'A Good Programmer <nospam@cpan.org>',
  PREREQ_PM    => {'Mojolicious' => '9.37'},
  test         => {TESTS => 't/*.t'}
);
