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

my @actions = $tutum->actions();
ok 1;
diag explain(@actions);

diag explain($actions[0]->cancel);

done_testing;
