



# флаги /a /aa
# use utf8
# use charnames ':full'
# 
$_ = "foo bar baz"; # -> foor, bar, baz
# оглядывание
print s/\w+/,/gr; # , , ,
print s/(\w+)/$1,/gr; # foo, bar, baz, 
print s/(\w+)\s+/$1,/gr; # foo,bar,baz
print s/(\w+)(?=\s+)/$1,/gr; #foo, bar, baz
print s/(\w+)(\s+)/$1,$2/gr; #foo, bar, baz
# вперед  OW+ -> (?=....)
# вперед OW- -> (?=....)
# назад OW+ -> (?=....)
# назад OW-  -> (?=....)
#!!!!!!!!!!!!!!!!!

# http header
$_ = "if-modified-since"; # => If-Modified-Since
print join "-", map ucfirst, split /-/,$_;
print s{(?<= - ) (.)}{\u$1}rgx # after -
=~ s{^(.)}{\u$1}rg             # leading
print s{
    (?:
    (?<= -)(.) # $1

    )
}

#!!!!!!!!!!!!!!!!!! branch reset

# оглядывание назад переменной длины
print s{
(?: - | ^)
\K
(.)
}{\u$1}rgx;




# разбиение на колонки
perl -an -E ''
# можно задать разделитель
perl -anF: -E ''
perl -anF

# Специальные переменные
#
#
#
#
# $. номер текущей строки во входном потоке
# Пример - самая длинная строка 
my $line ="";
while(<>){
    chomp;
    $line = $_ if length $line <length $_;
}
print $line,"\n";

#perl -lnE '$line = $_ if length $line <length }{ say $line' file

# Ретабуляция
