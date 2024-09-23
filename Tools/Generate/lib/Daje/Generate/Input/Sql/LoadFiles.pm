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
            $$path .= $filetype;
            $files = $path->list();
        } catch ($e) {
            die "Files could not be loaded: $e";
        }
    }


};


1;