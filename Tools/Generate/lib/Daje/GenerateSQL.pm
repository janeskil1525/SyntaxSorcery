use v5.40;
use feature 'class';
no warnings 'experimental::class';

our $VERSION = '0.01';

class Daje::GenerateSQL {
    use Daje::Generate::Input::Sql::LoadFiles;
    use Config::Tiny;
    field $config_path :param :reader = "";
    field $config :reader;

    method process () {
        $self->load_config();
        my $files = $self->load_file_list();

        return;
    }

    method load_file_list() {
        my $files = Daje::Generate::Input::Sql::LoadFiles->new(
            source_path => $config->{PATH}->{sql_source_dir},
            filetype    => '*.json',
        );
        $files->load_files();
        return $files->files();
    }

    method load_config () {
        try {
            $config = Config::Tiny->read($config_path);
        } catch ($e) {
            die "Could not load config '$e";
        }
    }
}






1;