#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

my $aref = [4,8,15]; # ссылка на массив(анонимный)
my $href = {k1 =>"v1"};

print $aref->[2],"\n"; #15
print $href->{k1},"\n"; # v1
print ref $aref,"\n"; #ARRAY 
print ref $href,"\n"; #HASH
#--------------------------------

my @array = [1,2,3]; # это ссылка!
print join ",", @array; # ARRAY(0x7dhsahj) - адрес в памяти
# аналогичная ошибка с хешом через фигурные скобки

#--------------------------------

my %hash = (key1=> (1,2), key2 => (3,4));
# списки разворачиваются в плоскуюструктуру
# получился хеш из 4 элементов: key1 => 1, 2=> key2, 3 => 4;
print $hash{key1},"\n"; # 1;
print $hash {key2},"\n"l # undef

#--------------------------------

my @AofA = (
    [1,2,3],
    [4,5,6],
    [7,8,9],
);
print $AofA[0],"\n"; # ARRAY(0x.....)
print $AofA[0][0],"\n";# 1
print $AofA[1][1],"\n";# 5
print $AofA[6][6],"\n";# обратиться позволит, но вызовет undef

my @AofAofA = ( # массив массивов массивов
    [[1,2,3],[4,5,6],[7,8,9]],
     [[1,2,3],[4,5,6],[7,8,9]],
);
print $AofAofA[0],"\n"; # ARRAY(0x...)
print $AofAofA[0][0],"\n"; # ARRAY(0x...)
print $AofAofA[0][0][0],"\n"; # 1

my $AofA = [  # тут скалар, эррей референс
    [1,2,3],
    [4,5,6],
    [7,8,9],
]
# через стрелку для ссылок
print $AofA->[0],"\n"; # ARRAY(0x.....)
print $AofA->[0][0],"\n";# 1
print $AofA->[1][1],"\n";# 5

print scalar @{ $AofA[0] }; #3 @{ - оператор разыменовывает ссылку в массив

push @{ $AofA[0] }, 4; # добавили в массив (разыменовали ссылку и добавили)

#cleanup
@{ $AofA[1] }= (); # make empty
$AofA[1]=[]; #create new

for my $row (@AofA){
    print ref $row,"\n"; #ARRAY
    print join ", ", @$row,"\n";
}

#--------------------------------
# Сложные структуры

my $var = 7;
my $key = "key";
my %hash = (
    sv => "string",
    av => [qw(some elements)], # Array ref
    hv => {                     # HASH ref
        nested => "value",
        $key => [1,2,$var],  # Array ref
    },
);

print $hash{sv},"\n"; #string
print $hash{av}->[1],"\n"; # elements
print $hash{av}[1],"\n"; #elements
print $hash{hv}{$key}[2],"\n"; # $var = 7;
print $hash{hv}->{$key}->[2],"\n"; # $var = 7;

# можно на хешр. реф
=my $hash = {...
....
};
say $hash->{sv};
....
=cut

#---------------------------
# Автооживление

my $href = {
    s => "string";
}
$href->{none}{key} = "exists"; # по ключу none(который хеш референс) по ключу кей кладу экзист
print $href->{none},"\n"; # HASH(0x...)

$href->{ary}[7]="seven";
print $href->{ary},"\n"; # Array(0x...)
print #!!!!!!

my $track = {
    name => "Nobody home",
    band => "pink Floyd",
    album => {name => "The wall", year => 1979}
}

#!!!!!!!!

print "'The wall' album"


#--------------
# символические ссылки

my $name = "var"
$$name = 1; # устанавливает в $var = 2
${$name} = 2;
@$name = (3,4); # устанавливает в @var (3,4)

$name->{key} = 7; # создает %var
                    # и делает $var{key} = 7

use strict 'refs'; # запрещает использование символич. ссылок
${ bareword } # = $bareword; ok
$ {"bareword"}; # not ok

$hash {key1}{key2} # ok

$hash {shift};  # в кач-ве хеша юзаем функцию. (по факту бареворд), но приведется к строке
$hash {+shift}; # указыввем, что явно не строка
$hash {shift()}; # иди так

#---------------------------

# use Data::Dumper;
# local $Data::Dumper::Maxdepth = 1;
# local $Data::Dumper:Sortkeys = 1;

my @list = (
    {name => "Dean", year => 1979},
     {name => "Dean", year => 1979},
)

my @sorted = sort {
    $a->{year} <=> $b->{year}
    ||
    $a->{name} cmp $b->{name}
} @list;
for (@sorted){
    print "$_->{name} ($_->{year})\n";
}

my @pic = (
    [{r=>123, g=>127, b=>27}],
)

my @gray = map{
    [
        map{
            int(($_->{r}+$_->{g}+$_->{b})/3)
        } @$_
    ];
} @pic;

#print Dumper \@gray....

#----------------------------
# самописный дампер с рекурсией


#----------------------------

#-------------
# Функции

sub math{
    my ($x, $y) = @_;

    if( wantarray){
        # called in list context
        return $X + $Y, $x - $y; # LIST
    }
    elsif(defined wantarray){
        # если ждут какой-то скаляр
        # но в таком случае он как-будто определен, но он не true
        return $x+$y; # SCALAR
    }
    else{ # == undef
        # никакого контекста
        return;
    }
}
sub test(){
    return wantarray ? "list":
    defined wantarray ? "scalar" :
    "void";
}
my @x = test; #list
my ($x) = test; #list
print test,"\n"; #list;
my $y = test; # scalar
print scalar test,"\n"; # scalar
1 + test; # scalar
if (test){...} # scalar, булево знач. - тоже скаляр
test(); # void

#-------------------
# Прототипы
sub test(){ # no args
    print "@_\n";
}
test(); # ok
test(1); # ошибка, много аргументов

sub test($){ # one scalar argument
    print "@_\n";
}
test(1); # ok
test(); # мало аргументо, ошибка

my @a = 1..3;
my %h = (k=>1, x=> 2);
test(@a); # ok
test (scalar(@a)); # ok, 3 обратиться в скалярном контексте -Ю кол-во элеентов
test(%h); #ok, 2/8 -> хеш в скалярном контекста: память есть под 8 ключей, но занято 2 из них

#----------------------
sub test(@); # list args
sub test(%); # also list args

test(); #ok
test(1,2,3); #ok
my %h = (k=>1, x=>2);
test(%h); #ok (k 1 x 2) or (x 2 k 1)

#--------
sub test($$;$); # два обязательно, 1 необязательно, всего три аргумента

test(1); # мало
test(1,2,3,4); # много
sub test($$;@);
# == sub test($$@)
#-----------------

sub test(_){ # один аругмент или $_
    print "@_\n";
}
test(1); #1
for (1..3){
    test(); # 1 2 3 (подставится локальная перем. $_)
}

#-------------------
my $s ="";
my @a = 1..3;
my %h = (k=>1, x=>2);

sub test (\@); # Хочу только массивы, однако массив не скпируется, а передастся по ссылке
# также с хешом и скаляром
# можно сразу sub test(\[@%$])

sub mypush(\@;@){
    my $ref = shift;
    my $offset = $#$ref+1; # начиная с какого индекса класть
    for my $i(0..$#_){
        $ref->[$offset+$i]=$_[$i];
    }
}
sub mypop(\@){
    my $ref = shift;
    my $val = $ref->[-1];
    $#$ref = $#$ref-1;
    return $val; # тупо двинули указатель на 1 назад
}

sub mymap(&@){ # & - тупо блок кода (анонимная функция)
    my $code = shift;
    my @r;
    push @r, $code->() for @_;
    @r;
}
sub mygrep(&@){
    my $code = shift;
    my @r;
    push @r,  $code->() for @_;
    @r;
}

print mymap {$_+2} 1..5,"\n"; # 3,4,5,6,7
print mygrep {$_%2} 1..5,"\n"; # 1,3,5
# !!!!!!!!!!!!!!!!!
#-----------------------------

# Why
print reverse 'dog',"\n";
#prints "dog", but
print ucfirst reverse 'dog',"\n";
# prints "God"?

print reverse 'dog',"cat","\n";
print scalar reverse 'dog',"\n";

#-----------
# constants

#------------
# Подавление прототипа

# если перед вызовом функции поставить &, то можно вызывать с любыми аргументами

#-----------------
# lvalue

my $t = "test";
substr($t,1,2)= "xx";
# t = txxt;

# sub test: lvalue{}

#-----------------
# hash + ub = handlers

my %ops = (
    '+'=> sub {$_[0] + $_[1]},
    '-' =? sub {$_[0] - $_[1]},
    ...
    '%' =? \&mod;
)
sub mod {return $_[0] % $_[1]}

# !!!!!!!!!!!!


#-----------------------
my $v = 5;
my @a = (1,2,sort 3, 4+$v, 6x2,7);
-MO=Deparse, -p
=(my $v = 5);
(
    my @a = (
        1,2,
        sort(
            3,
            (4+$v),
            (6 x 2),
            7
        )
    )
);
=cut
#-----------
# магия оператора инкремента
print ++($a = "a"),"\n";  # b






#------------------
# HERE-DOC              # Content of document
print <<EOD;            # for mins
Content of document
for $ENV{USER}
EOD

#print (<<'THIS', "but",<<THAT);
#No $inter;;;

#-----------
# регулярки

$re = qr/\d+/;
if ($a =~ m[test${re}]){...}

$b =~s{search}[replace]
y/A-Z/a-z/; # on $_; Большой букве будет сопост. маленькая такаяже


#----------
"hello" =~ m/hell/; # matches
"hello all" =~ m/hell/; # matches
"Hello" =~ m/hell/; # no matches
#----------
my $say = "Time ro drink a beer";

$say =~
#!!!!!!
#--------
# классы символов
# [...]
# /[abc]/ или а или б или с
# /[a-c]/ тоже самое
# [a-zA-Z]/ весь алфавит
# /[bcr]at/ bat или cat или rat
# [^...] отри

#!!!!!!!
#----------------
# Квантификаторы
# /\d{1,3}/ от 1 до 3 цифр
# "", "1", "12","123"

# /^\d{1,3}$/ начинается на число и длина от 1 до 3
# "1", "12", "123"

# /^\d{4}$/ только 4 числа

# /^\d{4,}$/ не менее 4 символов
# /^\d{4,}$/ от пусто строки до 4 символов


