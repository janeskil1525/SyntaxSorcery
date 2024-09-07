package GenerateSQL::Test::Templates;
use v5.40;

1;

__DATA__

@@ table

create table if not exists <<tablename>>
(
    <<tablename>>_pkey serial not null,
    editnum bigint NOT NULL DEFAULT 1,
    insby varchar NOT NULL DEFAULT 'System',
    insdatetime timestamp without time zone NOT NULL DEFAULT NOW(),
    modby varchar NOT NULL DEFAULT 'System',
    moddatetime timestamp without time zone NOT NULL DEFAULT NOW(),
    <<data>>
    CONSTRAINT <<tablename>>_pkey PRIMARY KEY (<<tablename>>_pkey)
    <<foregin_keys>>
):

@@ foregin_key

CONSTRAINT <<referenced_table>>_fkey FOREIGN KEY (<<referenced_table>>_fkey)
REFERENCES <<referenced_table>> (<<referenced_table>>_pkey) MATCH SIMPLE
                      ON UPDATE NO ACTION
                      ON DELETE NO ACTION
            DEFERRABLE
);