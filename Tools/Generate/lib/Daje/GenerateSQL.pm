use v5.40;
use feature 'class';
no warnings 'experimental::class';

our $VERSION = '0.01';

class Daje::GenerateSQL {

    use Daje::Generate::Input::Sql::ConfigManager;
    use Daje::Generate::Tools::FileChanged;
    use Daje::Generate::Sql::Table;
    use Daje::Generate::Output::Sql::Table;
    use Config::Tiny;

    field $config_path :param :reader = "";
    field $config :reader;
    field $config_manager;

    method process () {

        $self->load_config();
        my $files_list = $self->load_file_list();
        my $length = scalar @{$files_list};
        for (my $i = 0; $i < $length; $i++) {
            if ($self->process_sql(@{$files_list}[$i])) {
                $config_manager->save_new_hash(@{$files_list}[$i]);
            }
        }

        return;
    }

    method process_sql($file) {

        my $table = $self->load_table($file);
        my $sql = $table->generate_table();
        Daje::Generate::Output::Sql::Table->new(
            config => $config,
            file   => $file,
            sql    => $sql,
        )->save_file();

    }

    method load_table($file) {

        my $json = $config_manager->load_json($file);
        my $template $self->load_templates();
        my $table = try {
            Daje::Generate::Sql::Table->new(
                template => $template,
                json     => $json,
            );
        } catch ($e) {
            die "process_sql failed '$e";
        };

        return $table;
    }

    method load_templates() {
        my $template = try {
            return Daje::Generate::Tools::Datasections->new(
                data_sections => "table,foreign_key,index",
                source        => 'Generate::Templates::Sql'
            );
        } catch ($e) {
            die "load_templates failed '$e";
        };

        return $template;
    }

    method load_file_list() {

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

    method load_config () {
        try {
            $config = Config::Tiny->read($config_path);
        } catch ($e) {
            die "Could not load config '$e";
        };

        return;
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

