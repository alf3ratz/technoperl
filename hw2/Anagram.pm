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
=cut

sub anagram {
	my $words_list = shift;
	my %result;
	my $letters;
	my %temp;
	#for (@$words_list){
		#$_=lc($_);
	#}
	#my %uniq;
	#my @unique_arr = grep {!$uniq{$_}++} @$words_list;
	for my $elem (@$words_list){
		$elem = lc $elem;
		$letters = join ('',sort split(//,$elem));
		my $result_key = $temp{$letters} //= $elem;
		push @{$result{$result_key}}, $elem;
	}
	while(my ($k,$v) = each %result){
		my %uniq;
		@{$result{$k}} = grep {!$uniq{$_}++} @{$result{$k}};
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