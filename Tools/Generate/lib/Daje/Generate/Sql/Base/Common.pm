use v5.40;
use feature 'class';
no warnings 'experimental::class';

class Daje::Generate::Sql::Base::Common {
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







#################### pod generated by Pod::Autopod - keep this line to make pod updates possible ####################

=head1 NAME

lib::Daje::Generate::Sql::Base::Common - lib::Daje::Generate::Sql::Base::Common


=head1 DESCRIPTION

pod generated by Pod::Autopod - keep this line to make pod updates possible ####################


=head1 REQUIRES

L<feature> 

L<v5.40> 


=head1 METHODS


=cut

