package Local::Source::Text;

use strict;
use warnings;

use parent 'Local::Source';
#use base 'Local::Source';

sub new {
	my ($class, %args) = @_;
    unless (exists $args{delimiter}) {
    	$args{delimiter} = "\n";
    }
    $args{text} = [split $args{delimiter}, $args{text}];

	my $self = {array => $args{text}};
    $self->{counter}=0;
	return bless $self, $class;
}

=sub next {
    my $self = shift;
    if ( $self->{counter} == scalar @{$self->{array}} ) {
        return undef;
    }
    return $self->{array}->[$self->{counter}++];
}
=cut
1;