use v5.40;
use feature 'class';
no warnings 'experimental::class';

our $VERSION = '0.01';

class Daje::Generate::Output::Perl::Class {
    use Mojo::File;

    field $config :param ;
    field $table_name :param;
    field $perl :param;

    method save_file() {

        my $filename = $self->_create_new_filename();
        try {
            open (my $fh, ">", $filename) or die "Could not open file '$filename";
            print $fh $perl;
            close $fh;
        } catch ($e) {
            die "Daje::Generate::Output::Perl::Class::save_file '$e'"
        };

        return;
    }

    method _create_new_filename() {
        my $filename;
        try {
            $filename = $config->{PATH}->{name_space_dir} . $table_name . ".pm";
        } catch ($e) {
            die "create_new_filename failed '$e'";
        };

        return $filename;
    }
}


1;