use v5.40;
use feature 'class';
no warnings 'experimental::class';


class Daje::Generate::Input::Sql::LoadFiles {
    use Mojo::File;

    field $source_path :param :reader = "";
    field $files :reader = {};
    field $filetype :param :reader = "";

    method load_files () {
        try {
            my $path = Mojo::File->new($source_path);
            $files = $path->list();
        } catch ($e) {
            die "Files could not be loaded: $e";
        };
        my $length = scalar @{$files};
        for (my $i = 0; $i < $length; $i++) {
            my $changed = Daje::Generate::Tools::FileChanged->new(
                file_path_name =>  @{$files}[$i],
            );
            if ($changed->is_file_changed()) {

            }
        }

        return;
    }


};


1;