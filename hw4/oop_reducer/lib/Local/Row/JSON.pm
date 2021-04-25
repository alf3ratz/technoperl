package Local::Row::JSON;

use strict;
use warnings;
use JSON::XS;
use parent 'Local::Row';

sub new {
    my ($class, %args) = @_;
	eval {
        my $self = decode_json($args{str});
		return undef if (ref $self ne "HASH");
		return bless $self, $class;
	}or do{ return undef;};

}

1;