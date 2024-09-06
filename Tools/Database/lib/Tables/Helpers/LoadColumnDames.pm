package Tables::Helpers::LoadColumnDames;
use Mojo::Base   -base,  -signatures, -async_await;

has 'pg';

sub get_table_column_names($self, $table, $schema) {

    $schema = 'public' unless $schema;
    my @column_names = $self->pg->db->query(
        qq{
            SELECT column_name
                FROM information_schema.columns
            WHERE table_schema = ?
                AND table_name = ?
        }, ($schema, $table)
    )->hashes;

    @column_names = @{ $column_names[0] } if @{ $column_names[0] };
    return \@column_names;
}

1;