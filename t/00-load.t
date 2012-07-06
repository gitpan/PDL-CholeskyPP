#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'PDL::CholeskyPP' ) || print "Bail out!\n";
}

diag( "Testing PDL::CholeskyPP $PDL::CholeskyPP::VERSION, Perl $], $^X" );
