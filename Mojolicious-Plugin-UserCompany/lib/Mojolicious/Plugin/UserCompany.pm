package Mojolicious::Plugin::UserCompany;
use Mojo::Base 'Mojolicious::Plugin';

our $VERSION = '0.01';

sub register {
  my ($self, $app) = @_;

  $app->pg->migrations->name(
      'users'
  )->from_data(
      'Mojolicious::Plugin::UserCompany','users'
  )->migrate(1);

}

__DATA__
@@ users
-- 1 up
create table if not exists users
(
    users_pkey serial not null,
    editnum bigint NOT NULL DEFAULT 1,
    insby varchar NOT NULL DEFAULT 'System',
    insdatetime timestamp without time zone NOT NULL DEFAULT NOW(),
    modby varchar NOT NULL DEFAULT 'System',
    moddatetime timestamp without time zone NOT NULL DEFAULT NOW(),
    userid varchar not null unique,
    username varchar not null default '',
    passwd varchar not null,
    phone VARCHAR not null default '',
    support bigint DEFAULT 0,
    active bigint not null default 0,
    is_admin bigint not null default 0,
    CONSTRAINT users_pkey PRIMARY KEY (users_pkey)
    );
create table if not exists company_type
(
    company_type_pkey serial not null,
    company_type varchar not null default '' unique,
    CONSTRAINT company_type_pkey PRIMARY KEY (company_type_pkey)
    );

INSERT INTO company_type (company_type) VALUES ('SERVICE');

create table if not exists companies
(
    companies_pkey serial not null ,
    editnum bigint NOT NULL DEFAULT 1,
    insby varchar NOT NULL DEFAULT 'System',
    insdatetime timestamp without time zone NOT NULL DEFAULT NOW(),
    modby varchar NOT NULL DEFAULT 'System',
    moddatetime timestamp without time zone NOT NULL DEFAULT NOW(),
    name varchar not null default '',
    regno VARCHAR not null default '',
    homepage VARCHAR not null default '',
    phone VARCHAR not null default '',
    vatno VARCHAR not null default '',
    company_type_fkey integer not null ,
    CONSTRAINT companies_pkey PRIMARY KEY (companies_pkey),
    CONSTRAINT company_type_fkey FOREIGN KEY (company_type_fkey)
    REFERENCES company_type (company_type_pkey) MATCH SIMPLE
                          ON UPDATE NO ACTION
                          ON DELETE NO ACTION
    DEFERRABLE
    );

create table if not exists companies_users
(
    companies_users_pkey serial not null ,
    editnum bigint NOT NULL DEFAULT 1,
    insby varchar NOT NULL DEFAULT 'System',
    insdatetime timestamp without time zone NOT NULL DEFAULT NOW(),
    modby varchar NOT NULL DEFAULT 'System',
    moddatetime timestamp without time zone NOT NULL DEFAULT NOW(),
    companies_fkey integer not null,
    users_fkey integer not null,
    CONSTRAINT companies_users_pkey PRIMARY KEY (companies_users_pkey),
    CONSTRAINT companies_fkey FOREIGN KEY (companies_fkey)
    REFERENCES companies (companies_pkey) MATCH SIMPLE
                          ON UPDATE NO ACTION
                          ON DELETE NO ACTION
    DEFERRABLE,
    CONSTRAINT users_fkey FOREIGN KEY (users_fkey)
    REFERENCES users (users_pkey) MATCH SIMPLE
                          ON UPDATE NO ACTION
                          ON DELETE NO ACTION
    DEFERRABLE
    );
-- 1 down

1;

=encoding utf8

=head1 NAME

Mojolicious::Plugin::UserCompany - Mojolicious Plugin

=head1 SYNOPSIS

  # Mojolicious
  $self->plugin('UserCompany');

  # Mojolicious::Lite
  plugin 'UserCompany';

=head1 DESCRIPTION

L<Mojolicious::Plugin::UserCompany> is a L<Mojolicious> plugin.

=head1 METHODS

L<Mojolicious::Plugin::UserCompany> inherits all methods from
L<Mojolicious::Plugin> and implements the following new ones.

=head2 register

  $plugin->register(Mojolicious->new);

Register plugin in L<Mojolicious> application.

=head1 SEE ALSO

L<Mojolicious>, L<Mojolicious::Guides>, L<https://mojolicious.org>.

=cut


