use PDL::Core::Dev;            # Pick up development utilities
use ExtUtils::MakeMaker;
use strict;
use warnings;

my $package = ['choleskypp.pd','CholeskyPP','PDL::CholeskyPP'];

WriteMakefile(
          'NAME'          => 'PDL::CholeskyPP',
          'AUTHOR'        => 'T. Nishimura (tnish@fastmail.jp)',
          'LIBS'          => [],
          'INC'           => &PDL_INCLUDE(), # add include dirs as required by your lib
          'OBJECT'        => 'CholeskyPP$(OBJ_EXT)',
          'MAN3PODS'      => { 'CholeskyPP.pm' => '$(INST_MAN3DIR)/PDL::CholeskyPP.$(MAN3EXT)' },
          'clean'         => { 'FILES' => 'CholeskyPP.xs CholeskyPP.pm CholeskyPP$(OBJ_EXT) CholeskyPP.c' },
          'PM'            => { 'CholeskyPP.pm' => '$(INST_LIBDIR)/CholeskyPP.pm' },
          'TYPEMAPS'      => [&PDL_TYPEMAP()],
          'VERSION_FROM'  => 'choleskypp.pd',
          'ABSTRACT_FROM' => 'choleskypp.pd',
          'LICENSE'       => 'perl',
          'BUILD_REQUIRES' => { 
              'List::MoreUtils'     => 0,
              "ExtUtils::MakeMaker" => 0,
          },
          'PREREQ_PM' => {
              'Test::More' => 0,
              'PDL'        => '2.4.2',
          },
);

sub MY::postamble { pdlpp_postamble($package); }
