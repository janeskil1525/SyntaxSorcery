use v5.40;
use feature 'class';
no warnings 'experimental::class';

use Syntax::Keyword::Match qw(match);
use GenerateSQL::Sql::Base::Common;

class GenerateSQL::Sql::Table :isa(GenerateSQL::Sql::Base::Common){
    field $sql :reader = '';

    method generate_table() {

        if (exists($self->json->{tables})) {
            my $tables = $self->json->{tables};
            my $len = scalar @{$tables};
            for(my $j = 0; $j < $len; $j++){
                my $table = $self->shift_section($tables);
                $sql .= $self->create_table_sql($table);
            }
        }
    }

    method create_table_sql($table) {
        my $result = "";
        my $fields = '';
        my $indexes = '';

        if (exists($table->{table}->{fields})) {
            $fields = $self->create_fields($table->{table}->{fields})
        }
        if (exists($table->{table}->{index})) {
            $indexes = $self->create_index($table->{table}->{index})
        }
        $result = $self->template;
        $result =~ s/<<tablename>>/$table->{name}/;
        $result =~ s/<<fields>>/$fields/;
        my $test = 1;

    }

    method create_fields($fields){
        my $ressult = '';
        while (my ($key, $value) = each %{$fields}) {
            $ressult .= $key . ' ' . $value . $self->get_defaults($value) . ',';
        }
        return $ressult;
    }

    method get_defaults($datatype) {
        my $result = "";
        match($datatype : eq) {
            case('bigint') { $result = " not null default 0 "}
            case ('varchar') { $result = " not null default '' "}
            default { $result = '' }

        }
        return $result;
    }

    method create_index($index) {
        my $result = '';
    }
}




1;