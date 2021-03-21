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
        #@sorted_arr = sort {($b <=> $a ) || ($b cmp $a)} @arr;
        my @word = sort {$b cmp $a} grep {  /^[a-z]/i } @arr;
        my @num  = sort {$b <=> $a} grep { !/^[a-z]/i } @arr;
        @sorted_arr = (@num,@word);
    }
    else {
        @sorted_arr = sort {$b cmp $a} @arr;
    }
}
else {
    if ($n) {
        #@sorted_arr = sort {($a <=> $b) || ($a cmp $b)} @arr;
        my @word = sort {$a cmp $b} grep {  /^[a-z]/i } @arr;
        my @num  =  sort {$a <=> $b} grep { !/^[a-z]/i } @arr;
        @sorted_arr = (@num,@word);
    }
    else {
        @sorted_arr = sort {$a cmp $b} @arr;
    }
}
if ($u) {
    my %uniq;
    my @unique = grep {!$uniq{$_}++} @sorted_arr;
    @sorted_arr = @unique;
}
print join "\n", @sorted_arr, "\n";

