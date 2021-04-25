package Local::Row;

use strict;
use warnings;

=sub new {
	my ($class, %args) = @_; 
	return bless \%args, $class;
}
=cut

sub get {
	my ($self, $name, $default) = @_;
    if(exists $self->{$name}){
        return $self->{$name};
    }
    return $default;
}
1;