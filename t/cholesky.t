#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 2;
use PDL;
use PDL::CholeskyPP;
use List::MoreUtils qw//; # need all

sub random_posdef{
    my ($n) = @_;

    # rows (dim 0) are unit-vectors
    my $unit_vectors = grandom($n, $n); 
    $unit_vectors = $unit_vectors / (($unit_vectors * $unit_vectors)->sumover()->sqrt()->dummy(0)) ;

    # create matrix of dot products
    my $m = [];
    for (my $i = 0 ; $i < $n ; ++$i){
        my $ith = $unit_vectors->slice(":,($i)");
        $m->[$i][$i] = ($ith * $ith)->sumover();

        for (my $j = $i + 1 ; $j < $n ; ++$j){
            $m->[$i][$j] = $m->[$j][$i] = ($ith * $unit_vectors->slice(":,($j)"))->sumover();
        }
    }
    return pdl $m;
}

my @results;
for my $i (1 .. 10) {
    for my $dim (2,3,4,5, 10, 20) {
        my $m = random_posdef($dim);
        my $cd = $m->cholesky();

        if ( $cd->badflag() ){
            push @results, 0;
        }
        else{
            my $sq = $cd->transpose() x $cd;
            push @results, all($sq - $m < .00001);
        }
    }
}

ok(List::MoreUtils::all(sub { $_ }, @results), "cholesky decomposition on randomly generated posdef matrices");

@results = ();
for my $i (1 .. 10) {
    for my $dim (2,3,4,5, 10, 20) {
        my $m = random_posdef($dim);

        $m->slice(':,0') .= 0; # make matrix singular

        my $cd = $m->cholesky();
        push @results, $cd->badflag();
    }
}

ok(List::MoreUtils::all(sub { $_ }, @results), "cholesky decomposition on singular matrices fails");
