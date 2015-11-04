package Mojolicious::Plugin::RequestBase;
use Mojo::Base 'Mojolicious::Plugin';

our $VERSION = '0.1';

sub register {
  my ($self, $app, $config) = @_;

  $app->hook(
    before_dispatch => sub {
      my $c = shift;
      if (my $base = $c->req->headers->header('X-Request-Base')) {
        $c->req->url->base(Mojo::URL->new($base));
      }
    }
  );
}

1;
__END__

=head1 NAME

Mojolicious::Plugin::RequestBase - Support setting base in frontend proxy

=head1 SYNOPSIS

=head2 Reverse proxy

  # nxinx
  proxy_set_header X-Request-Base "https://example.com/myapp";

=head2 Application

  # Mojolicious
  $app->plugin("RequestBase");

  # Mojolicious::Lite
  plugin "RequestBase";

=head2 Controller

Request to C<https://example.com/myapp/foo> with C<X-Request-Base> set to
C<https://example.com/myapp>.

  # https://example.com/myapp/foo
  $c->url_for->to_abs;

  # https://example.com/myapp/some/path
  $c->url_for("/some/path")->to_abs;

  # https://example.com/foo (Probably not what you want)
  $c->req->url->to_abs;

=head1 DESCRIPTION

Simple plugin to support Request Base header. Just load it and set
X-Request-Base in your Frontend Proxy. For instance, if you are using
nginx you could use it like this: 

  proxy_set_header X-Request-Base 'https://example.com/myapp';

=head1 METHODS

L<Mojolicious::Plugin::RequestBase> inherits all methods from
L<Mojolicious::Plugin> and implements the following new ones.

=head2 register

  $plugin->register;

Register plugin in L<Mojolicious> application.

=head1 SEE ALSO

L<Catalyst::TraitFor::Request::ProxyBase>, L<Mojolicious>, L<Mojolicious::Guides>, L<http://mojolicio.us>.

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2011, Marcus Ramberg.

This program is free software, you can redistribute it and/or modify it under
the terms of the Artistic License version 2.0.

=cut
