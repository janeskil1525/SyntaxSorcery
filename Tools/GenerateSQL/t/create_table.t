#!/usr/bin/perl
use v5.40;

use Test::More;
use Test::Mojo;
use GenerateSQL::Test::TestData;

use Mojo::Loader qw {data_section};
use Mojo::JSON qw {from_json};

sub create_table {

    my $sql = data_section('GenerateSQL::Test::TestData', 'users.sql');
    my $json = from_json(data_section('GenerateSQL::Test::TestData', 'users.json'););

    my $test = 1;
}

ok(create_table() == 1);
done_testing();
1;

__DATA__

