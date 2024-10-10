package Daje::Generate::Perl::CreateSchema;
use Mojo::Base -base, -signatures;

use Scalar::Util qw {reftype};
use Syntax::Operator::Matches qw( matches mismatches );

has 'pg';
has 'log';

sub get_tables($self, $excluded, $schema) {
    $schema = 'public' unless $schema;

    my @methods = ();
    my @tables = $self->_get_tables($schema);
        my $length = scalar @tables;
    for (my $i = 0; $i < $length; $i++) {
        my $table = $tables[$i];
        my $column_names = $self->get_table_column_names($table->{table_name}, $schema);
        $method->{column_names} = $column_names;
        push (@methods, $method);
        my $temp = 1;
    }

    my @views = $self->_get_views($schema);
    $length = scalar @views;
    for (my $i = 0; $i < $length; $i++ ) {
        my $view = $views[$i];
        my $column_names = $self->get_table_column_names($view->{table_name}, $schema);
        my $method = $self->build_view_methods($view, $column_names);
        $method->{column_names} = $column_names;
        push (@methods, $method);
    }
    my $meth = \@methods;

    return $meth;
}

sub build_view_methods($self, $view, $column_names) {

    my $methods->{table_name} = $view->{table_name};
    $methods->{keys} = $self->_get_keys($column_names);
    $methods->{create_endpoint} = 1;
    my $method = $self->get_view_list($view->{table_name},$column_names);
    push @{$methods->{methods}}, $method ;

    return $methods;
}

sub _get_keys($self, $column_names) {

    my $keys->{has_companies} = 0;
    $keys->{has_users} = 0;
    $keys->{fk} = ();
    my $length = scalar @{$column_names};
    for (my $i = 0; $i < $length; $i++ ) {
        if (length(@{$column_names}[$i]->{column_name}) > 0) {
            if (index(@{$column_names}[$i]->{column_name},'_pkey') > -1){
                $keys->{pk} = @{$column_names}[$i]->{column_name};
            } elsif (@{$column_names}[$i]->{column_name} eq 'companies_fkey') {
                $keys->{has_companies} = 1;
            } elsif (@{$column_names}[$i]->{column_name} eq 'users_fkey') {
                $keys->{has_users} = 1;
            } elsif (index(@{$column_names}[$i]->{column_name},'_fkey') > -1) {
                push @{$keys->{fk}}, @{$column_names}[$i]->{column_name};
            }
        }
    }
    return $keys;
}

sub _get_tables($self, $schema) {

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


sub _get_views($self, $schema) {
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