package Local::Source::Array;

use strict;
use warnings;
use parent 'Local::Source';


sub new {
    my ($class, %args) = @_;
    my $self = {array => $args{array}};
    $self->{counter} = 0;
    return bless $self, $class;
}

=sub next {
    my $self=shift;
	return $self->{array}[$self->{counter}++]; 
}
=cut
1;