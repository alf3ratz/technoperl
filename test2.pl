#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

my @arr = (3,"123",5);
print "arr = @arr\n";
$" = ';';
print "arr = @arr\n";
print "1st = $arr[0]\n";
my @simple = qw(a b c); # == ('a', 'b', 'c')
my $arref = [1,2,3,4,5]; # = анонимный массив

my $arref1 = [@arr]; # происходит копирование массива и создание анонимного массива
my $arref2= [(@arr)]; # сначала пытается сделать в список, а потмо из списка в анонимны массив
my $arref3 = \@arr; # реальная ссылка на массив (ссылка на массив - скаляр)
print "index of arr\'s last element = ",$#arr,"\n";
# тот же самый результат в виде: $#$arref3
print "arr\'s length = ",scalar @arr,"\n";
# тот же самый результат в виде: scalar @{$arref3}
my $element = $arref3->[2]; # разыменование ссылки 
$element = ${$arref3}[2]; # аналогичное разыменование ссылки
my @array;
$array[0]=1;
$array[1] = 2;
$array[7] = 7;
# print "4th elem = $array[3]\n"; -> вылетит ошибка, т.к. после [1] до [7] лежит undef
use Data::Dumper;
print Dumper \@array,"\n"; # красивый вывод массива, для дебага н-р.

@array = (4,8,15,16,23,42);

print join ",", @array[0,2,4],"\n"; # будет напечатан срез через запятую
@array[5..7] = (10,20,30); # снова срез с присваиванием

my %first = ( # Ключ - ВСЕГДА СТРОКА, значение - любой скаляр
    key1 => "value1", # => - жИрНаЯ запятая
    key2 => "value2",
);
=my %second - ( # в предыдущем хеше перл сам привел ключ к строке
    'key3',"value3",
    'key4', "value4",
);
=cut

my %third = qw(key5 value5 key6 value6);
my %all = (%first, %second, %third); # это не список хешей, а новый хеш, но просто проиниц. списком хешей

my $href = \%hash; # ссылка на хеш

my $href = { # анонимный хеш, ссылка на хеш
    key1 => "value1",
    key2 => "value2",
};

my @array  = qw(key1 val1 key2 val2);
my %hash = @array; # хеш можно инициализировать массивом

my $aref = [qw(key1 val1 key2 val2)];
my %hash = @{$aref}; # инициализация ссылкой (происх. копирование)

my $hashref = {@array};
my $hashref = {@{$aref}};

# BAREWORD - строчка без кавычек
# бареворды можно юзать в хешах

my %hash = (key1 => "val1");
print "${hash{key2}}\n";

my %hash; # объявление хеша и его ссылки, чтобы можно было потом их заполнить
my $href = {};
$hash{key1} = "val1";
$href->[key1]="val1";
# ну или же разименованием
${$href}{key3} = "value";


my %simple = qw(k1 1 k2 2);
my %hash = (key3 => 3, key4 -> "four", %simple);

my $key = "key3";

print joib ",", %simple,"\n"; # получим: k2,2,k1,1
# или же k1,1,k2,2 - хеши несортированные
# можно также написать все ключи или значения
print join ",", keys %hash,"\n";
print join ",", values %hash,"\n";

# можно использовать срезы хешей, обязательно собачка
print join ",", @hash {"k1", $key); # 1, 3

# можно удалять ключ из хеша
my $one = delete $hash{k1};
print $one,"\n"; # напишет 1

# можно проверять, есть ли такой элемент в хеше
print $hash{k2} if exists $hash{k2},"\n"; # 2

 
# если передать в ссылку скаляр, то вернется пустая стркоа ''
print ref $scalar, "\n";
print ref \@array,"\n"; # будет напечатано ARRAY

# можно писать условные конструкции на проверку скаляра на ссылку
if(ref $val){
#если ссылка, то..
}else{

}

# Встроенные функции
# eval - блок кода или строка, которую нвжно интерпретировать
# как программу и если произ. искл, то eval перехватит и прога не остановится
eval "syntax:invalid";
warn $@ if $@;
# Например:
eval {$a/$b;};
warn $@ if $@ # Если b - ноль, то напишется эксепшн и прога продолжит работу

# die - выбрасывание исключения
# $< - служебная переменная - айди пользователя
eval {die "Not root" if $<;};
warn $@ if $@;

#
eval { #try
    #...;
1} or do { # catch
    warn "Error: $@";
};

# chop b сhomp
# chop - отрезает последний символ строки
# chomp - обрезает разделитель строк (только)
$/ = "\r\n";
$a = $b = "test\r\n";

chop($a),chop($a),chop($a); # уберет \n, потом \r, потом t
chomp($b),chomp($b); # уберет \r\n, потом ничего

# index, rindex, substr, length
$_ = "some average string\n";
# index($_," ") -> вернет индекс 4, т.е. индекс первого пробела
# substr($_,3,5) -> веренет "e ave"
# rindex($_," ") -> вернет индекс 12, т.е. индекс последнего пробела

# для массивов
my @a;
push @a,1; # @a = (1)
push @a, 2,3,4; # @a = (1,2,3,4)

my $x = pop @a; # @a = (1,2,3), $x = 4;
my $y = shift @a; # @a = (2,3), $y = 1
unshift @a, 7,8; # @a = (7,8,2,3)
mt @a = (1,2,3,4,5,6,7);

my @b = splice(@a,1,3,(8,9));
# @a = 1,8,9,5,6,7
# @b = 2,3,4

# цикл for лучше писать так:
for my $i (0..$#a){}
for my $var (@a) {}
for (@a){
    #$_
}
while (my($i,$v)= each @array){ # each копирует -> изменений с исх. мас. не произойдет
    print "$i: $v\n";
    $v++;
}

my %hash = (key1 => "value1", key2 => "value2", key3 => "value3");

for my $key (keys %hash){ # итерация по хешу
    print $key, "\n";
    print $hash{$key},"\n";
    $key.="+1"; # .= конкатинация строк
}

=OUT_LIST = grep {
    #... какое-то условие
} IN_LIST # в новый массив пойжут элементы, подходящие под условие
=cut
# например
my @stringg = ('qw','sd','zx');
my @nonempty = grep {length $_} @strings;
# добавятся все, т.к. длина всех >0
my $odd = grep {$_ %2 } 1..100;

# map
my @squares = map {$_ **2} 1..5; #1,4,9,16,25
#
#
#
#
#


