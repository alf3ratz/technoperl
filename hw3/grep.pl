use strict;
use 5.010;
use warnings;
use Getopt::Long qw(GetOptions);
use Getopt::Long qw(:config no_ignore_case bundling);

my ($a, $b, $c);
my ($cnt, $ignore_case, $invert, $fixed, $show_line_num);
my $p = '';

GetOptions (
            'A=s' => \$a,
            'B=s' => \$b,
            'C=s' => \$c,
            'c'   => \$cnt,
            'i'   => \$ignore_case,
            'v'   => \$invert,
            'F'   => \$fixed,
            'n'   => \$show_line_num,
            'P'=>\$p
            );

my $lines_after = 0;
my $lines_before = 0;


if (defined $a) {
    $lines_after=$a;
    if (defined $b) {
        $lines_before=$b;
    }
    elsif (defined $c) {
        $lines_before=$c;
    }
}
elsif (defined $c) {
    $lines_after=$c;
    if (defined $b) {
        $lines_before=$b;
    }
    else {
        $lines_before=$c;
    }
}
elsif (defined $b) {
    $lines_before=$b;
}


my $pattern;

if (defined $ARGV[0]) {
    $pattern = defined $fixed ? quotemeta($ARGV[0]) :
               defined $ignore_case ? qr/$ARGV[0]/i : qr/$ARGV[0]/;
} else {
    say "No pattern provided";
    exit -1;
}

#say $pattern;

sub check {
    my ($line) = @_;
    return defined $invert ? !($line =~ $pattern) : $line =~ $pattern;
}

my @res = ();
my @lines = ();

my @buf = ();

while (<STDIN>) {
    chomp($_);
    push @lines, $_;
    push @buf, 0;
    if (check($_)) {
        push @res, $. - 1;
    }
}

sub print_line {
    my ($line, $num) = @_;
    if ($show_line_num) {
       say $buf[$num - 1] == 2 ? "$num:$line" : "$num-$line";
    } else {
        say "$line";
    }
}

sub print_context {
    my $num;
    for $num (@res) {
        @buf[$num] = 2;
        my $tmp_ceil = $num - $lines_before < 0 ? 0 : $num - $lines_before;
        my $tmp_floor = $num + $lines_after > scalar @lines - 1 ? scalar @lines - 1 : $num + $lines_after;
        while ($tmp_ceil <= $tmp_floor) {
            if (!$buf[$tmp_ceil]) {
                $buf[$tmp_ceil] = 1;
            }
            $tmp_ceil++;
        }
    }
    my $flag = 0;
    for (0..scalar @buf) {
        if ($buf[$_]){
            if ($flag and $_ - 1 > -1 and $buf[$_ - 1] == 0){
                if(defined $a or defined $c or defined $b){
                    say "--";
                }
            }
            $flag = 1;
            print_line($lines[$_], $_+1);
        }
    }
}

if (defined $cnt){
    say scalar @res;
} else {
    print_context();
}
