#!/usr/bin/perl
use v5.40;

use Test::More;
use Generate::Test::TestData;
use Generate::Sql::Table;
use Generate::Templates::Sql;
use Mojo::Log;

use Mojo::Loader qw {data_section};
use Mojo::JSON qw {from_json};

# = ["table","foreign_key","index"]
# 'GenerateSQL::Template::Templates'
sub generate_table_sql()  {

    my $json = from_json (qq{
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
                  "index": [
                    {"type": "unique", "fields": "userid"}
                  ]
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
    });

    my $template = Generate::Tools::Datasections->new(
        data_sections => "table,foreign_key,index" ,
        source        => 'Generate::Templates::Sql'
    );
    $template->load_data_sections();

    my $result = Generate::Sql::Table->new(
        json     => $json,
        template => $template,
    );

    $result->generate_table();
}

ok(generate_table_sql() == 1);

done_testing();

