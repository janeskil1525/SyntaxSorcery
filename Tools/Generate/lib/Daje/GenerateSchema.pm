use v5.40;
use feature 'class';
no warnings 'experimental::class';


our $VERSION = '0.01';

class Daje::GenerateSchema :isa(Daje::Generate::Base::Common) {
    use Daje::Generate::Perl::CreateSchema;

    field $config_path :param :reader = "";
    field $config :reader;

    method process () {
        $self->_load_config();
        my $schema = $self->_load_db_schema();
        my $json = $self->_build_json($schema);
        $self->_save_json($json);


    }

    method _load_db_schema() {
        my $dbschema = Daje::Generate::Perl::CreateSchema->new(
            $config->{DATABASE}->{connection}
        )->get_db_schema('public');

        return $dbschema;
    }

    method _build_json($schema) {

    }

    method _save_json($json) {


    }
}
1;