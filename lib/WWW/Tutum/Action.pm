package WWW::Tutum::Action;
use strict;
use warnings;
use Time::Piece;
use Class::Accessor::Lite (
     ro => [qw[ tutum ]],
     rw => [qw[
         action 
         can_be_canceled 
         can_be_retired
         created
         end_date
         ip
         location
         method
         object
         path
         resource_uri
         start_date
         state
         user_agent
         uuid
    ]],
    new => 0,
);

sub new {
    my ($class, %opts) = @_;
    $opts{$_} = $opts{$_} ? Time::Piece->strptime($opts{$_}, '%a, %e %b %Y %H:%M:%S %z') : undef for qw/created end_date start_date/;
    bless {%opts}, $class;
}


sub cancel {
    my $self = shift;
    $self->tutum->req(POST => $self->resource_uri. 'cancel/');
}

sub retry {
    my $self = shift;
    $self->tutum->req(POST => $self->resource_uri. 'retry/');
}

1;
