#!/usr/bin/env perl
use Mojo::Base -strict;
use Test::More;

use Mojolicious::Lite;
use Test::Mojo;

plugin 'RequestBase';

get '/' => sub {
  my $c = shift;
  $c->render(text=>$c->url_for('login'));
};

get '/login', 'login';

my $t = Test::Mojo->new;
$t->get_ok('/')->status_is(200)->content_is('/login');

$t->get_ok('/', {'X-Request-Base' => 'http://example.com/foo'})->status_is(200)->content_is('/foo/login');

done_testing;
