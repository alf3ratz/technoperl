package Local::Source;
use strict;
use warnings;

sub new  {
	my($class, %args) = @_;
    $args{counter}=0;
	return bless \%args, $class;
}
sub next {
	my $self = shift;
    if ($self->{counter} == scalar @{$self->{array}} ) {
        return undef;
    }
    return $self->{array}->[$self->{counter}++];
}

sub has_next {
	my $self = shift;
	return ($self->{counter} != (scalar @{$self->{array}}) );
}
1;