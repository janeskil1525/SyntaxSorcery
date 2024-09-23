use v5.40;
use feature 'class';
no warnings 'experimental::class';

our $VERSION = '0.01';

class Daje::GenerateSQL {
    use Daje::Generate::Input::Sql::LoadFiles;

    method process () {

    }

    method load_file_list() {
        my $files = Daje::Generate::Input::Sql::LoadFiles->new(
            source_path => '',
            filetype    => '.json',
        )
    }
}






1;