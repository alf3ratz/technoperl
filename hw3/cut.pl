#!/usr/bin/env perl

use strict;
use 5.010;
use warnings;
use Getopt::Long qw(GetOptions);
use Getopt::Long qw(:config no_ignore_case bundling);
use Scalar::Util qw(looks_like_number);

my $f;
my $delimeter;
my $separated;
my @arr = ();
my @fields = ();
my @sorted_arr = ();
GetOptions( 
	"f=s" => \$f,
	"s" => \$separated,
	"d:s" => \$delimeter
);
if($f){
    my @fields_temp = split /,/, $f;
	my %uniq;
	@fields = grep { !$uniq{$_}++ } @fields_temp;
    #@fields = sort {$a <=> $b} @fields;
    @fields = sort map{$_} grep{looks_like_number($_)} @fields_temp;
    if(@fields<@fields_temp){
        @fields = ();
    }
}

unless (defined $delimeter) {
  $delimeter = "\t";
}

my @row_array = ();
my @result_array = ();
if($f){
	while (<>) {
  		chomp($_);
        my @row_elems = split /$delimeter/,$_;
        if(scalar @row_elems >1){            
                my @temp_array = map{$_-1}grep{($_>0)and($_<=scalar @row_elems)}@fields;
                @row_array = @{[@{row_elems}[@temp_array]]};
                say join "$delimeter",@row_array;
        }else{
            unless($separated){
                say join "$delimeter",@row_elems;
            }
        }
        @row_array = ();
	}
}



