use strict;
use Test::More;
use WWW::Tutum;

unless ($ENV{TUTUM_USERNAME} && $ENV{TUTUM_APIKEY}) {
    plan skip_all => 'Request test requires env values TUTUM_USERNAME and TUTUM_APIKEY';
}

my $tutum = WWW::Tutum->new(
    username => $ENV{TUTUM_USERNAME},
    apikey   => $ENV{TUTUM_APIKEY},
);

my $res = $tutum->req(get => '/api/v1/node/');
ok $res;
diag explain($res);

done_testing;
