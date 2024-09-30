use v5.40;
use feature 'class';
no warnings 'experimental::class';

our $VERSION = '0.01';

class Daje::Generate::Database::Operations {

    field $dbh :param;

    method save_hash($file, $hash) {
        try {
            my $date = localtime();
            my $script = $self->save_script();
            my $sth = $dbh->prepare($script);
            $sth->execute($file, $hash, $date, $hash, $date);
        } catch ($e) {
            die "Save hash failed '$e";
        }
    }

    method load_hash($file_path_name) {
        my $hash;
        try {
            my $script = $self->select_script();
            my $sth = $dbh->prepare($script);
            $sth->execute($file_path_name);
            $hash = $sth->fetch();
        } catch ($e) {
            die "Could not load hash '$e";
        };

        return $hash;
    }

    method select_script() {
        return qq{
            SELECT hash FROM file_hashes WHERE file = ?;
        };
    }

    method save_script() {
        return qq{
            INSERT INTO file_hashes (file, hash, moddatetime)
                VALUES (?,?,?)
                    ON CONFLICT (file)
                DO UPDATE set hash = ?, moddatetime = ?;
        };
    }
}


1;