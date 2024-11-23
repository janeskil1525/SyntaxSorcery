use v5.40;
use feature 'class';
no warnings 'experimental::class';

our $VERSION = '0.01';

class Daje::Generate::Perl::Generate::BaseClass {
    field $config :param;
    field $template :param;

    method generate() {
        my $tpl = $template->get_data_section('baseclass');

        my $base_name_space = $config->{CLASS}->{base_name_space};

        $tpl =~ s/<<base_name_space>>/$base_name_space/ig;

        my $output = Daje::Generate::Output::Perl::Class->new(
            config         => $config,
            table_name     => "Base",
            perl           => $tpl,
            name_space_dir => "base_space_dir",
        );
        $output->save_file();
    }
}


1;