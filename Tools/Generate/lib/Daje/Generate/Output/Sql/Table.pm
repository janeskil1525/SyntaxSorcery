use v5.40;
use feature 'class';
no warnings 'experimental::class';


our $VERSION = '0.01';

class Daje::Generate::Output::Sql::Table {
    use Mojo::File;

    field $config :param ;
    field $file :param;
    field $sql :param;

    method save_file() {

        my $filename = $self->create_new_filename();
        open (my $fh, ">", $filename) or die "Could not open file '$filename";
        print $fh $sql;
        close $fh;

        return;
    }

    method create_new_filename() {
        my $filename = try {
            my $path = $config->{PATH}->{sql_target_dir} . Mojo::File->new($file)->basename();
            $path =~ s/json/sql/ig;
            return $path;
        } catch ($e) {
            die "create_new_filename failed '$e'";
        };

        return $filename;
    }

}




1;