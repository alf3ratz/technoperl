#!/usr/bin/env perl
use 5.016;
use warnings;
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
for (@arr) {
    chomp($_);
}

if ($r) {
    if ($n) {
        my @word = sort {$b cmp $a} grep {  /[^\d]/i } @arr;
        my @num  = sort {$b <=> $a} grep { /[+-]?([0-9]*[.,])?[0-9]+/i } @arr;
        @sorted_arr = (@num,@word);
    }
    else {
        @sorted_arr = sort {$b cmp $a} @arr;
    }
}
else {
    if ($n) {
        my @word = sort {$a cmp $b} grep {  /[^\d]/i } @arr;
        my @num  =  sort {$a <=> $b} grep { /[+-]?([0-9]*[.,])?[0-9]+/i } @arr;
        @sorted_arr = (@num,@word);
    }
    else {
        @sorted_arr = sort {$a cmp $b} @arr;
    }
}
if ($u) {
    my %uniq;
    @sorted_arr = grep {!$uniq{$_}++} @sorted_arr;
}
print join "\n", @sorted_arr, "\n";

