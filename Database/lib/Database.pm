package Database;
use Mojo::Base 'Sentinel::Helpers::Sentinelsender', -signatures, -async_await;

our $VERSION = '0.01';

use Database::Postgres;
use Database::Model::Postgres;

has 'pg';
has 'log';
has 'dist_dir';
has 'tables';

sub get_tables($self) {

    $self->log->debug("Database::get_tables start");
    eval {
        $self->pg->migrations->from_data('migrations');
    };
    $self->log->error($@) if $@;

    my $data->{companies_fkey} = 0;
    $data->{users_fkey} = 0;
    my $table->{table_name} = 'database_excludes';
    $table->{keys}->{fk} = ();
    $table->{table}->{list}->{select_fields} = 'table_name';

    eval {
        my $excluded = Database::Model::Postgres->new(
            pg => $self->pg, log => $self->log
        )->list($data, $table);

        my $tables = Database::Postgres->new(
            pg => $self->pg, log => $self->log
        )->get_tables($excluded,'public');

        $self->tables($tables);
    };
    $self->log->error($@) if $@;

    $self->log->debug("Database::get_tables stop");

    return $tables;
}

__DATA__
@@ migrations

-- 1 up
CREATE TABLE IF NOT EXISTS database_excludes
(
    database_excludes_pkey serial NOT NULL ,
    editnum bigint NOT NULL DEFAULT 1,
    insby varchar NOT NULL DEFAULT 'System'::character varying,
    insdatetime timestamp without time zone NOT NULL DEFAULT now(),
    modby varchar NOT NULL DEFAULT 'System'::character varying,
    moddatetime timestamp without time zone NOT NULL DEFAULT now(),
    table_name varchar UNIQUE NOT NULL,
    CONSTRAINT database_excludes_pkey PRIMARY KEY (database_excludes_pkey)
);

INSERT INTO database_excludes (table_name) VALUES
        ('database_specials'),
        ('database_excludes'),
        ('workflow_stockitem'),
        ('workflow_pricelist'),
        ('workflow_companies'),
        ('workflow_users'),
        ('workflow_customer'),
        ('workflow_mail'),
        ('workflow_invoice'),
        ('mojo_migrations'),
        ('workflow'),
        ('workflow_history');

CREATE TABLE IF NOT EXISTS database_specials
(
    database_specials_pkey serial NOT NULL ,
    editnum bigint NOT NULL DEFAULT 1,
    insby varchar NOT NULL DEFAULT 'System'::character varying,
    insdatetime timestamp without time zone NOT NULL DEFAULT now(),
    modby varchar NOT NULL DEFAULT 'System'::character varying,
    moddatetime timestamp without time zone NOT NULL DEFAULT now(),
    table_name varchar NOT NULL,
    method varchar NOT NULL,
    select_fields VARCHAR NOT NULL DEFAULT '',
    fkey VARCHAR NOT NULL DEFAULT '',
    table_schema VARCHAR NOT NULL DEFAULT 'public',
    method_pseudo_name VARCHAR NOT NULL DEFAULT 'public',
    pkey VARCHAR NOT NULL DEFAULT '',
    CONSTRAINT database_specials_pkey PRIMARY KEY (database_specials_pkey)
);

INSERT INTO database_specials (table_name, method, select_fields, fkey, method_pseudo_name, pkey)
VALUES('companies', 'load', '*', '', '', 'companies_pkey');

INSERT INTO database_specials (table_name, method, select_fields, fkey, method_pseudo_name, pkey)
VALUES('users', 'load', '*', '', '', 'users_pkey');
 -- 1 down

1;