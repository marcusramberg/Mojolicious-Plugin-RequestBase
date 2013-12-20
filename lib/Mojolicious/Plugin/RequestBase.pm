package Mojolicious::Plugin::RequestBase;
use Mojo::Base 'Mojolicious::Plugin';

our $VERSION = '0.1';

sub register {
  my ($self, $app) = @_;
  $app->hook(before_dispatch => sub {
    my $this=shift;
    if(my $base=$this->req->headers->header('X-Request-Base')) {
      $this->req->url->base(Mojo::URL->new($base));
    }
  });
}

1;
__END__

=head1 NAME

Mojolicious::Plugin::RequestBase - Support setting base in frontend proxy

=head1 SYNOPSIS

  # Mojolicious
  $self->plugin('RequestBase');

  # Mojolicious::Lite
  plugin 'RequestBase';

=head1 DESCRIPTION

Simple plugin to support Request Base header. Just load it and set
X-Request-Base in your Frontend Proxy. For instance, if you are using
nginx you could use it like this: 

   proxy_set_header X-Request-Base 'https://mojolicio.us/myapp';

=head1 METHODS

L<Mojolicious::Plugin::RequestBase> inherits all methods from
L<Mojolicious::Plugin> and implements the following new ones.

=head2 C<register>

  $plugin->register;

Register plugin in L<Mojolicious> application.

=head1 SEE ALSO

L<Catalyst::TraitFor::Request::ProxyBase>, L<Mojolicious>, L<Mojolicious::Guides>, L<http://mojolicio.us>.

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2011, Marcus Ramberg.

This program is free software, you can redistribute it and/or modify it under
the terms of the Artistic License version 2.0.

=cut
