package Tables::Helpers::LoadViews;
use Mojo::Base   -base,  -signatures, -async_await;

has 'pg';

sub get_views($self, $schema) {
    my $views_stmt = qq {
        SELECT table_name
            FROM
              information_schema.views
            WHERE
              table_schema NOT IN (
                'information_schema', 'pg_catalog'
              ) AND table_schema = ?
            ORDER BY table_name;
    };

    my @views = $self->pg->db->query($views_stmt,($schema))->hashes;
    @views =  @{$views[0]};

    return @views;
}

1;