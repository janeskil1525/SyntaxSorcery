package GenerateSQL::Test::TestData;
use v5.40;

1;

__DATA__

@@ users.sql
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
DROP TABLE users;
DROP TABLE company_type;
DROP TABLE companies;
DROP TABLE companies_users;

@@ users.json


  {
           "tables": [
          {
             "table": {
              "name": "users",
              "fields": {
                "userid": "varchar",
                "username": "varchar",
                "password": "varchar",
                "phone": "varchar",
                "active": "bigint",
                "support": "bigint",
                "is_admin": "bigint"
              },
              "index": {
                "type": "unique",
                "fields": "userid"
              }
            }
          },
          {
            "table": {
            "name": "company_type",
            "fields": {
              "company_type": "varchar"
            }
            },
            "index": {
              "type": "unique",
              "fields": "company_type"
            }
          },
          {
            "table": {
              "name": "companies",
              "fields": {
                "name": "varchar",
                "regno": "varchar",
                "homepage": "varchar",
                "phone": "varchar",
                "vatno": "varchar",
                "company_type_fkey": "bigint"
              }
            }
          },
          {
            "table": {
              "name": "companies_users",
              "fields": {
                "companies_fkey": "bigint",
                "users_fkey": "bigint"
              }
            }
          }
        ]
      }


