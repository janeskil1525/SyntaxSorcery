#!/usr/bin/perl
use strict;
use warnings;
use Test::More;

use Data::Load::Datasections;
use GenerateSQL::Template::Templates;
use GenerateSQL::Sql::Table::Fields;
use Mojo::JSON qw{from_json};

sub test_create_fields {
    my $json = from_json( qq (
        {
            "fields": {
                "userid": "varchar",
                "username": "varchar",
                "password": "varchar",
                "phone": "varchar",
                "active": "bigint",
                "support": "bigint",
                "is_admin": "bigint"
            }
        }
    ));
    my $template = Data::Load::Datasections->new(
        data_sections => "table,foregin_key,index" ,
        source        => 'GenerateSQL::Template::Templates'
    );

    my $result = GenerateSQL::Sql::Table::Fields->new(
        json     => $json,
        template => $template,
    )->create_fields();
}

ok(test_create_fields() == 1);
done_testing();

