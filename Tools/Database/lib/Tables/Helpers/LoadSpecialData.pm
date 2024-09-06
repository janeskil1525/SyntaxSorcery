package Tables::Helpers::LoadSpecialData;
use Mojo::Base   -base,  -signatures, -async_await;

has 'pg';

sub get_specials_data($self, $table, $schema) {

    $schema = 'public' unless $schema;
    my $specials = $self->pg->db->query(
        qq{
            SELECT method, select_fields, fkey, pkey, method_pseudo_name
                FROM database_specials
            WHERE table_schema = ?
                AND table_name = ?
        }, ($schema, $table)
    )->hashes;

    return $specials;
}
1;