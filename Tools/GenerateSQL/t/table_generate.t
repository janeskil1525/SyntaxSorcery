#!/usr/bin/perl
use v5.40;

use Test::More;
use GenerateSQL::Test::TestData;
use GenerateSQL::Sql::Table;
use GenerateSQL::Template::Templates;
use Mojo::Log;

use Mojo::Loader qw {data_section};
use Mojo::JSON qw {from_json};

# = ["table","foreign_key","index"]
# 'GenerateSQL::Template::Templates'
sub generate_table_sql()  {
    my $log = Mojo::Log->new(
        path => 'home/jan/Project/SyntaxSorcery/Tools/GenerateSQL/Log/generate_table_sql.log',
        level => 'debug'
    );

    my $sql = data_section('GenerateSQL::Test::TestData', 'users.sql');
    my $template->{table} = data_section('GenerateSQL::Template::Templates', 'table');
    $template->{foregin_key} = data_section('GenerateSQL::Template::Templates', 'foregin_key');
    $template->{index} = data_section('GenerateSQL::Template::Templates', 'index');

    my $json = from_json(data_section('GenerateSQL::Test::TestData', 'users.json'));

    my $result = GenerateSQL::Sql::Table->new(
        json     => $json,
        template => $template,
        log      => $log
    )->generate_table();
}

ok(generate_table_sql() == 1);

done_testing();

