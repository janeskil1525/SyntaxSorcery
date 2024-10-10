-- Auto generated file Sun Oct  6 16:41:33 2024
-- This file might be recreated so any manual changes might be overwritten

-- 1 up

create table if not exists users
(
    users_pkey serial not null,
    editnum bigint NOT NULL DEFAULT 1,
    insby varchar NOT NULL DEFAULT 'System',
    insdatetime timestamp without time zone NOT NULL DEFAULT NOW(),
    modby varchar NOT NULL DEFAULT 'System',
    moddatetime timestamp without time zone NOT NULL DEFAULT NOW(),
    active bigint not null default 0 
,is_admin bigint not null default 0 
,password varchar not null default '' 
,phone varchar not null default '' 
,support bigint not null default 0 
,userid varchar not null default '' 
,username varchar not null default '' 
,
    CONSTRAINT users_pkey PRIMARY KEY (users_pkey)
    
);

CREATE unique INDEX idx_users_userid
    ON users USING btree
        (userid);




create table if not exists company_type
(
    company_type_pkey serial not null,
    editnum bigint NOT NULL DEFAULT 1,
    insby varchar NOT NULL DEFAULT 'System',
    insdatetime timestamp without time zone NOT NULL DEFAULT NOW(),
    modby varchar NOT NULL DEFAULT 'System',
    moddatetime timestamp without time zone NOT NULL DEFAULT NOW(),
    company_type varchar not null default '' 
,
    CONSTRAINT company_type_pkey PRIMARY KEY (company_type_pkey)
    
);




create table if not exists companies
(
    companies_pkey serial not null,
    editnum bigint NOT NULL DEFAULT 1,
    insby varchar NOT NULL DEFAULT 'System',
    insdatetime timestamp without time zone NOT NULL DEFAULT NOW(),
    modby varchar NOT NULL DEFAULT 'System',
    moddatetime timestamp without time zone NOT NULL DEFAULT NOW(),
    company_type_fkey bigint not null default 0 
,homepage varchar not null default '' 
,name varchar not null default '' 
,phone varchar not null default '' 
,regno varchar not null default '' 
,vatno varchar not null default '' 
,
    CONSTRAINT companies_pkey PRIMARY KEY (companies_pkey)
    ,  CONSTRAINT idx_company_type_fkey FOREIGN KEY (company_type_fkey)
REFERENCES company_type (company_type_pkey) MATCH SIMPLE
                      ON UPDATE NO ACTION
                      ON DELETE NO ACTION
            DEFERRABLE



);

  CREATE  INDEX idx_companies_company_type_fkey
    ON companies USING btree
        (company_type_fkey);




create table if not exists companies_users
(
    companies_users_pkey serial not null,
    editnum bigint NOT NULL DEFAULT 1,
    insby varchar NOT NULL DEFAULT 'System',
    insdatetime timestamp without time zone NOT NULL DEFAULT NOW(),
    modby varchar NOT NULL DEFAULT 'System',
    moddatetime timestamp without time zone NOT NULL DEFAULT NOW(),
    companies_fkey bigint not null default 0 
,users_fkey bigint not null default 0 
,
    CONSTRAINT companies_users_pkey PRIMARY KEY (companies_users_pkey)
    ,  CONSTRAINT idx_companies_fkey FOREIGN KEY (companies_fkey)
REFERENCES companies (companies_pkey) MATCH SIMPLE
                      ON UPDATE NO ACTION
                      ON DELETE NO ACTION
            DEFERRABLE


,  CONSTRAINT idx_users_fkey FOREIGN KEY (users_fkey)
REFERENCES users (users_pkey) MATCH SIMPLE
                      ON UPDATE NO ACTION
                      ON DELETE NO ACTION
            DEFERRABLE



);

  CREATE  INDEX idx_companies_users_companies_fkey
    ON companies_users USING btree
        (companies_fkey);

  CREATE  INDEX idx_companies_users_users_fkey
    ON companies_users USING btree
        (users_fkey);






-- 1 down



