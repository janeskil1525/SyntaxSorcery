package Tables::Helpers::LoadTables;
use Mojo::Base   -base,  -signatures, -async_await;

has 'pg';

sub get_tables($self, $schema) {

    my $tables_stmt = qq {
        SELECT table_name
          FROM information_schema.tables
         WHERE table_schema = ?
           AND table_type='BASE TABLE';
    };

    my @tables = $self->pg->db->query($tables_stmt,($schema))->hashes;
    @tables = @{ $tables[0] };

    return @tables;
}
1;