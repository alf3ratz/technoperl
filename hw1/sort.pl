#!/usr/bin/env perl
use 5.016;
use warnings;
no warnings 'numeric';
use Getopt::Long qw(GetOptions); # для обработки аргументов
my $n;
my $r;
my $u;
my @arr = ();
my @sorted_arr = ();
GetOptions('n' => \$n,
    'r'        => \$r,
    'u'        => \$u);
@arr = <>;
if($r){
    for(@arr){
        chomp($_);
    }
}
if($n){
    @sorted_arr =sort { ($a <=> $b) || (fc($a) cmp fc($b)) } @arr;
}else{
    @sorted_arr =sort {fc($a) cmp fc($b)} @arr;
}
if ($u) {
    my %uniq;
    my @unique = grep {!$uniq{$_}++} @sorted_arr;
    @sorted_arr = @unique;
}
if($r){
    my @rev = reverse @sorted_arr;
     @sorted_arr = @rev;
}
unless ($r) {
    for(@sorted_arr){
        chomp($_);
    }
}
print join "\n", @sorted_arr,"\n";

