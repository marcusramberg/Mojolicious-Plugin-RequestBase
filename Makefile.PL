#!/usr/bin/env perl

use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  NAME         => 'Mojolicious::Plugin::RequestBase',
  VERSION_FROM => 'lib/Mojolicious/Plugin/RequestBase.pm',
  AUTHOR       => 'Marcus Ramberg <mramberg@cpan.org>',
  PREREQ_PM    => {'Mojolicious' => '1.90'},
  test         => {TESTS => 't/*.t'}
);
