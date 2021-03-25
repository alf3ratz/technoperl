package Anagram;
# vim: noet:

use 5.016;
use warnings;
binmode(STDIN,':utf8');
binmode(STDOUT, ':utf8');
use utf8;

=head1 SYNOPSIS
Поиск анаграмм
=head1 anagram($arrayref)

Функция поиска всех множеств анаграмм по словарю.

Входные данные для функции: ссылка на массив - каждый элемент которого - слово на русском языке в кодировке utf8

Выходные данные: Ссылка на хеш множеств анаграмм.

Ключ - первое встретившееся в словаре слово из множества
Значение - ссылка на массив, каждый элемент которого слово из множества, в том порядке в котором оно встретилось в словаре в первый раз.

Множества из одного элемента не должны попасть в результат.

Все слова должны быть приведены к нижнему регистру.
В результирующем множестве каждое слово должно встречаться только один раз.
Например

anagram(['пятак', 'ЛиСток', 'пятка', 'стул', 'ПяТаК', 'слиток', 'тяпка', 'столик', 'слиток'])

должен вернуть ссылку на хеш


{
	'пятак'  => ['пятак', 'пятка', 'тяпка'],
	'листок' => ['листок', 'слиток', 'столик'],
}

=cut

sub anagram {
	my $words_list = shift;
	my %result;
	my $letters;
	my %temp;
	for (@$words_list){
		$_=lc($_);
	}
	my %uniq;
    my @unique_arr = grep {!$uniq{$_}++} @$words_list;
	for my $elem (@unique_arr){
		$letters = join ('',sort split(//,$elem));
		if(exists $temp{$letters}){
			 push @{$result{$temp{$letters}}}, $elem;
		}else{
			$temp{$letters} = $elem;
        	$result{$elem} = [$elem];
			#push @{$result{$letters}}, $elem;
		}
    }
	while(my ($k,$v) = each %result){
		if (@{$result{$k}} == 1) {
        	delete $result{$k};
      	}
		else{
			@{$result{$k}} = sort @{$result{$k}};
		}
	}
	return \%result;
}

1;
