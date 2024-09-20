use v5.40;
use feature 'class';
no warnings 'experimental::class';

use Generate::Sql::Table::Fields;
use Generate::Sql::Table::Index;
use Generate::Sql::Table::ForeignKey;

class Generate::Sql::Table :isa(Generate::Sql::Base::Common){

    method generate_table() {
        my $sql = "";
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
        my $foreignkeys = "";
        my $template = $self->template->get_section('table');
        my $name = $table->{table}->{name};
        if (exists($table->{table}->{fields})) {
            $fields = $self->create_fields($table->{table}->{fields});
            $foreignkeys = $self->create_fkeys($table->{table}->{fields}, $name);
        }

        if (exists($table->{table})) {
            $indexes = $self->create_index($table->{table})
        }

        $template =~ s/<<fields>>/$fields/ig;
        $template =~ s/<<tablename>>/$name/ig;
        $template =~ s/<<foregin_keys>>/$foreignkeys->{template_fkey}/ig;
        $indexes .= '\n' . $foreignkeys->{template_ind};
        $template =~ s/<<tablename>>/$indexes/ig;

        my $test = 1;

    }
    method create_fields($json) {
        my $fields = Generate::Sql::Table::Fields->new(
            json     => $json,
            template => $self->template,
        );

        $fields->create_fields();
        my $sql = $fields->sql;

        return $sql;
    }

    method create_index($json) {
        my $test = 1;
        my $index = Generate::Sql::Table::Index->new(
            json      => $json,
            template  => $self->template,
            tablename => 'users',
        );

        $index->create_index();
        my $sql = $index->sql;
        return $sql;
    }

    method create_fkeys($json, $table_name) {
        my $foreignkeys = {};
        my $foreign_key = Generate::Sql::Table::ForeignKey->new(
            json      => $json,
            template  => $self->template,
            tablename => $table_name,
        );
        $foreign_key->create_foreign_keys();
        if ($foreign_key->created() == 1) {
            $foreignkeys = $foreign_key->templates();
        }
        return $foreignkeys;
    }
}




1;



#################### pod generated by Pod::Autopod - keep this line to make pod updates possible ####################

=head1 NAME

lib::GenerateSQL::Sql::Table - lib::GenerateSQL::Sql::Table


=head1 DESCRIPTION

pod generated by Pod::Autopod - keep this line to make pod updates possible ####################


=head1 REQUIRES

L<feature> 

L<v5.40> 


=head1 METHODS


=cut

