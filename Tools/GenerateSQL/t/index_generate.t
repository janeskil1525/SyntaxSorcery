#!/usr/bin/perl
use strict;
use warnings;
use Test::More;

use GenerateSQL::Sql::Table::Index;
use GenerateSQL::Tools::Datasections ;
use GenerateSQL::Template::Templates;

use Mojo::JSON qw {from_json};

sub test_generate_index {
    my $test = qq{CREATE unique INDEX idx_users_userid
    ON users USING btree
        (userid);


};
    my $result = 0;
    my $json = from_json(qq{{"index": [
                {"type": "unique", "fields": "userid"}
              ]}}
    );

    my $template = GenerateSQL::Tools::Datasections->new(
        data_sections => "table,foregin_key,index" ,
        source        => 'GenerateSQL::Template::Templates'
    );
    $template->load_data_sections();

    my $index = GenerateSQL::Sql::Table::Index->new(
        json      => $json,
        template  => $template,
        tablename => 'users',
    );

    $index->create_index();

    my $sql = $index->sql;
    if($sql eq $test) {
        $result = 1;
    }
    return $result;
}

ok(test_generate_index() == 1);
done_testing();

