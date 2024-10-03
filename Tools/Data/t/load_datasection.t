#!/usr/bin/perl
use strict;
use warnings;
use Test::More;

use Data::Load::Datasections;

sub test_load_data_section {
    my $result = 0;
    my $test = "test";
    my $template = GenerateSQL::Tools::Datasections->new(
        data_sections => "test1,test2" ,
        source        => 'GenerateSQL::Test::Datasections'
    );
    $template->load_data_sections();

    my $section = $template->get_data_section('test1');
    $result = 1 if (defined($section));
    return $result;
}

sub test_set_templates {
    my $result = 0;
    my $test = "test";
    my $template = GenerateSQL::Tools::Datasections->new(
        data_sections =>  "test1, test2",
        source       => 'GenerateSQL::Test::Datasections'
    );
    $template->add_data_section("test");
    my $templates = $template->data_sections;
    if (index($templates, $test) > -1) {
        $result = 1;
    }

    return $result;
}

sub test_set_source {
    my $result = 0;
    my $test = "test";
    my $template = GenerateSQL::Tools::Datasections->new(
        data_sections =>  "test1, test2",
        source       => 'GenerateSQL::Test::Datasections'
    );
    $template->set_source("test");
    my $source = $template->source;
    if ($source eq 'test') {
        $result = 1;
    }

    return $result;
}

sub test_set_data_section {
    my $result = 0;
    my $test = "test";
    my $template = GenerateSQL::Tools::Datasections->new(
        data_sections =>  "test1, test2",
        source       => 'GenerateSQL::Test::Datasections'
    );
    $template->set_data_section("test","Hello World");
    my $section = $template->get_data_section("test");
    if ($section eq "Hello World") {
        $result = 1;
    }

    return $result;
}

ok(test_set_templates() == 1);
ok(test_set_source() == 1);
ok(test_load_data_section() == 1);
ok(test_set_data_section() == 1);
done_testing();

