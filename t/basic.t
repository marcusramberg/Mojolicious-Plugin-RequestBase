#!/usr/bin/env perl
use Mojo::Base -strict;
use Test::More;

use Mojolicious::Lite;
use Test::Mojo;

plugin 'RequestBase';

get '/' => sub {
  my $c = shift;
  $c->render(text => $c->url_for('login'));
};

get '/redirect' => sub {
  my $c   = shift;
  my $url = $c->req->url->to_abs;
  $c->redirect_to("http://example.com?from=$url");
};

get '/login', 'login';

my $t = Test::Mojo->new;
$t->get_ok('/')->status_is(200)->content_is('/login');

$t->get_ok('/', {'X-Request-Base' => 'http://example.com/foo'})->status_is(200)
  ->content_is('/foo/login');

$t->get_ok('/redirect', {'X-Request-Base' => 'http://mojolicio.us/foo'})
  ->status_is(302)
  ->header_is(
  Location => 'http://example.com?from=http://mojolicio.us/foo/redirect');

done_testing;
