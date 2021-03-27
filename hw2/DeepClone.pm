package DeepClone;
# vim: noet:

use 5.016;
use warnings;

=encoding UTF8

=head1 SYNOPSIS

Клонирование сложных структур данных

=head1 clone($orig)

Функция принимает на вход ссылку на какую либо структуру данных и отдаюет, в качестве результата, ее точную независимую копию.
Это значит, что ни один элемент результирующей структуры, не может ссылаться на элементы исходной, но при этом она должна в точности повторять ее схему.

Входные данные:
* undef
* строка
* число
* ссылка на массив
* ссылка на хеш
Элементами ссылок на массив и хеш, могут быть любые из указанных выше конструкций.
Любые отличные от указанных типы данных -- недопустимы. В этом случае результатом клонирования должен быть undef.

Выходные данные:
* undef
* строка
* число
* ссылка на массив
* ссылка на хеш
Элементами ссылок на массив или хеш, не могут быть ссылки на массивы и хеши исходной структуры данных.

=cut

sub clone {
    my $orig = shift;
    my $refs = shift;
    my $cloned;
	if (my $ref = ref $orig) {
		if(defined $refs->{$orig}) {
            $cloned = $refs->{$orig};
		}
		else {
			if ($ref eq 'ARRAY') {
				$cloned = [];
				$refs->{$orig} = $cloned;
				push @{$cloned}, clone($_, $refs) for @{$orig};
			}
			elsif ($ref eq 'HASH') {
				$cloned = {};
				$refs->{$orig} = $cloned;
				while (my ($k,$v) = each %{$orig}) {
					$cloned->{$k} = clone($v, $refs);
				}
			}
			else{
				$cloned = undef;
			}
		}
	}
	else {
		$cloned = $orig;
	}
	return $cloned;
}
1;