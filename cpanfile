requires 'perl', '5.008001';
requires 'URI';
requires 'JSON';
requires 'LWP::UserAgent';
requires 'HTTP::Request';
requires 'HTTP::Headers';
requires 'LWP::Protocol::https';
requires 'Class::Accessor::Lite';

on 'test' => sub {
    requires 'Test::More', '0.98';
};

