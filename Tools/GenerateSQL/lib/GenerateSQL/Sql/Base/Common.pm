use v5.40;
use feature 'class';
no warnings 'experimental::class';

class GenerateSQL::Sql::Base::Common {
    field $log :param :reader;
    field $json :param :reader;
    field $template :param :reader;
    field $sql :reader;
    field $index = 0;
    field $version :reader;

    method shift_section ($array) {
        my $result = {};
        my $test = ref $array;
        if (ref $array eq 'ARRAY') {
            $result = shift(@{$array});
        }
        return $result;
    }
    method set_sql($sqlin) {
        $sql = $sqlin;
    }
}

1;