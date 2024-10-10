use v5.40;
use feature 'class';
no warnings 'experimental::class';

our $VERSION = '0.01';

class Daje::GenerateSQL :isa(Daje::Generate::Base::Common) {

    use Daje::Generate::Input::Sql::ConfigManager;
    use Daje::Generate::Tools::FileChanged;
    use Daje::Generate::Sql::SqlManager;
    use Daje::Generate::Output::Sql::Table;
    use Daje::Generate::Tools::Datasections;
    use Config::Tiny;

    field $config_path :param :reader = "";
    field $config :reader;
    field $config_manager;

    method process () {

        $self->_load_config();
        my $files_list = $self->_load_file_list();
        my $length = scalar @{$files_list};
        for (my $i = 0; $i < $length; $i++) {
            if ($self->_process_sql(@{$files_list}[$i])) {
                $config_manager->save_new_hash(@{$files_list}[$i]);
            }
        }

        return;
    }

    method _process_sql($file) {
        my $sql = "";
        try {
            my $table = $self->_load_table($file);
            $table->generate_table();
            $sql = $table->sql();
        } catch ($e) {
            die "Create sql failed '$e'";
        };

        try {
            Daje::Generate::Output::Sql::Table->new(
                config => $config,
                file   => $file,
                sql    => $sql,
            )->save_file();
        } catch ($e) {
            die "Could not create output '$e'";
        };

        return 1;
    }

    method _load_table($file) {

        my $json = $config_manager->load_json($file);
        my $template = $self->_load_templates(
            'Daje::Generate::Templates::Sql',
            "table,foreign_key,index,section,file"
        );
        my $table;
        try {
            $table = Daje::Generate::Sql::SqlManager->new(
                template => $template,
                json     => $json,
            );
        } catch ($e) {
            die "process_sql failed '$e";
        };

        return $table;
    }



    method _load_file_list() {

        try {
            $config_manager = Daje::Generate::Input::Sql::ConfigManager->new(
                source_path => $config->{PATH}->{sql_source_dir},
                filetype    => '*.json'
            );
            $config_manager->load_changed_files();
        } catch ($e) {
            die "could not load changed files '$e";
        };

        return $config_manager->changed_files();
    }

}






1;

#################### pod generated by Pod::Autopod - keep this line to make pod updates possible ####################

=head1 NAME

lib::Daje::GenerateSQL - lib::Daje::GenerateSQL


=head1 DESCRIPTION

pod generated by Pod::Autopod - keep this line to make pod updates possible ####################


=head1 REQUIRES

L<Config::Tiny> 

L<Daje::Generate::Sql::Table> 

L<Daje::Generate::Tools::FileChanged> 

L<Daje::Generate::Input::Sql::ConfigManager> 

L<feature> 

L<v5.40> 


=head1 METHODS


=cut

