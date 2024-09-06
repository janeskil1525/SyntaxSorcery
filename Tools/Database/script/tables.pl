#!/usr/bin/perl
### # !/opt/ActivePerl-5.26/bin/perl

use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../lib" }

use Moo;
use MooX::Options;
use Cwd;
use Config::Tiny;
use Log::Log4perl qw(:easy);
use Mojo::Pg;
use feature 'say';
use feature 'signatures';
use Tables;
use namespace::clean -except => [qw/_options_data _options_config/];


option 'configpath' => (
    is 			=> 'ro',
    required 	=> 1,
    reader 		=> 'get_configpath',
    format 		=> 's',
    doc 		=> 'Configuration file',
    default 	=> '/home/jan/Project/SyntaxSorcery/Tools/Database/conf/'
);

sub tables ($self){
    Log::Log4perl->easy_init($ERROR);
    my $log = Log::Log4perl->get_logger();

    eval {
        Log::Log4perl::init($self->get_configpath() . 'tables.conf');
    };
    $log->error('Tables ' . $@) if $@;
    say $@ if $@;

    my $config;
    eval {
        $config = get_config($self->get_configpath() . 'tables.ini');
    };
    $log->error('tables.ini ' . $@) if $@;
    say $@ if $@;
    my $pg = Mojo::Pg->new()->dsn(
        $config->{DATABASE}->{pg}
    );

    Tables->new(pg => $pg, config => $config)->process('public');
}

sub get_config{
    my ($configfile) = @_;

    my $log = Log::Log4perl->get_logger();
    $log->logdie("config file name is empty")
        unless ($configfile);

    my $config = Config::Tiny->read($configfile);
    $log->logdie("config file could not be read")
        unless ($config);

    return $config;
}

main->new_with_options->tables();