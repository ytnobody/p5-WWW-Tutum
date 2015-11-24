package WWW::Tutum;
use 5.008001;
use strict;
use warnings;
use Carp;
use JSON ();
use URI;
use LWP::UserAgent;
use HTTP::Request;
use HTTP::Headers;
use Class::Accessor::Lite (
    ro => [qw[username apikey json agent]],
    new => 0,
);
use WWW::Tutum::Action;

our $VERSION = "0.01";
our $TIMEOUT = 60;
our $REST_URL = 'https://dashboard.tutum.co/';

sub new {
    my ($class, %opts) = @_;
    $opts{json} = JSON->new->utf8(1);
    $opts{agent} = LWP::UserAgent->new(agent => "$class/$VERSION", timeout => $TIMEOUT);
    bless +{ %opts }, $class;
}

sub build_request {
    my ($self, $method, $path, $params) = @_;

    my $uri = URI->new($REST_URL);
    $uri->path($path);
    my $headers = HTTP::Headers->new(
        Authorization => sprintf('ApiKey %s:%s', $self->username, $self->apikey),
        Accept        => 'application/json',
    );
    my $body;

    if ($method =~ /\Aget\z/i) {
        if ($params) {
            $uri->query_form($params);
        }
    }
    elsif ($method =~ /\Apost\z/i) {
        $headers->push_header(Content_type => 'application/json; charset=utf-8');
        $body = $params ? $self->json->encode($params) : undef;
    }

    HTTP::Request->new($method, $uri->as_string, $headers, $body);
}

sub req {
    my $self = shift;

    my $req = $self->build_request(@_);
    my $res = $self->agent->request($req);

    if ($res->is_success) {
        return $self->json->decode($res->content);
    }
    else {
        carp(
            sprintf('%s: %s',
                $res->status_line,
                $res->content ? $self->json->decode($res->content)->{error} : undef
            )
        );
    }
}

sub actions {
    my ($self, %opts) = @_;
    my $res = $self->req(GET => '/api/v1/action/', {%opts});
    map {WWW::Tutum::Action->new(%{$_}, tutum => $self)} @{$res->{objects} || []};
}

1;
__END__

=encoding utf-8

=head1 NAME

WWW::Tutum - It's new $module

=head1 SYNOPSIS

    use WWW::Tutum;

=head1 DESCRIPTION

WWW::Tutum is ...

=head1 LICENSE

Copyright (C) ytnobody.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=cut

