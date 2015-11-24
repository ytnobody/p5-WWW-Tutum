use strict;
use Test::More;
use WWW::Tutum;

unless ($ENV{TUTUM_USERNAME} && $ENV{TUTUM_APIKEY}) {
    plan skip_all => 'request test requires env values TUTUM_USERNAME and TUTUM_APIKEY';
}

my $tutum = WWW::Tutum->new(username => $ENV{TUTUM_USERNAME}, apikey => $ENV{TUTUM_APIKEY});
my $req = $tutum->build_request(GET => '/api/v1/service/');

isa_ok $req, 'HTTP::Request';

diag explain($req->as_string);

done_testing;
