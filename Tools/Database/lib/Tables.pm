package Tables;
use Mojo::Base   -base,  -signatures, -async_await;

use Tables::Helpers::LoadViews;
use Tables::Helpers::LoadTables;


has 'pg';
has 'config';


sub process ($self, $schema) {


    my @tables = Tables::Helpers::LoadTables->new(pg => $self->pg)->get_tables($schema);
    my $length = scalar @tables;
    for (my $i = 0; $i < $length; $i++) {
        my $table = $tables[$i];
        my $column_names = $self->get_table_column_names($table->{table_name}, $schema);
        my $specials = $self->get_specials_data($table->{table_name}, $schema);
        my $test = 1;
    }
    my @views = Tables::Helpers::LoadViews->new(pg => $self->pg)->get_views($schema);
    $length = scalar @views;
    for (my $i = 0; $i < $length; $i++) {
        my $view = $views[$i];
    }

    my $test = 1

}


1;