use v5.40;
use feature 'class';
no warnings 'experimental::class';

our $VERSION = '0.01';

class Daje::GeneratePerl :isa(Daje::Generate::Base::Common) {
    use Mojo::JSON qw{from_json};
    use Mojo::File;
    use Daje::Generate::Perl::PerlManager;

    method process() {
        $self->_load_config();
        my $json = $self->_get_json();
        $self->_create_perl($json);
    }

    method _create_perl($json) {
        my $template = $self->_load_templates(
            'Daje::Generate::Templates::Perl',
            "class,method,baseclass,interface,load_from_pkey,load_from_fkey,load_list,insert_data,update_data,fields_method"
        );

        my $manager = Daje::Generate::Perl::PerlManager->new(
            config      => $self->config(),
            template    => $template,
            json        => $json,
        )->generate_classes();

        return $manager->success()
    }

    method _get_json() {
        my $path = $self->config->{PATH}->{schema_dir};
        my $json_txt = Mojo::File->new($path . "schema.json")->slurp();
        my $json = from_json($json_txt);

        return $json;
    }
}


1;
#################### pod generated by Pod::Autopod - keep this line to make pod updates possible ####################

=head1 NAME

lib::Daje::GeneratePerl - lib::Daje::GeneratePerl


=head1 REQUIRES

L<Daje::Generate::Perl::PerlManager> 

L<feature> 

L<v5.40> 


=head1 METHODS


=cut

