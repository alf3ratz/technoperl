package Local::Source::FileHandle;

use strict;
use warnings;

use parent 'Local::Source';

sub new {
	my ($class, %args) = @_;
    return bless \%args, $class;
}
sub next {
    my $self = shift;
	my $fh = $self->{fh};
	my $string = <$fh>;
	if ($string) {
		chomp $string;
		return $string;
	}
	else {
		return undef;
	}

}


1;