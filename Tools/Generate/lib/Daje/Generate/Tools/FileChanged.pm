use v5.40;
use feature 'class';
no warnings 'experimental::class';

our $VERSION = '0.01';

class Daje::Generate::Tools::FileChanged {
    use Daje::Generate::Tools::SqlLite;
    use Digest::SHA qw(sha256_hex);
    use Mojo::File;
    use DBI;

    field $file_path_name :reader :param = "";
    field $path ;
    field $dbh;


    method is_file_changed() {
        $path = Mojo::File->new($file_path_name);
        $self->open_database();

        my $new_hash = $self->load_new_hash();

    }

    method open_database() {
        my $database = Daje::Generate::Tools::SqlLite->new(
            path => $path
        );
        $database->open_database();
        $dbh = $database->dbh;
    }


    method load_new_hash() {

        my $file_content = $path->slurp;
        my $hash = sha256_hex($file_content);

        return $hash;
    }
}


1;