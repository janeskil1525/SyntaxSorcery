use v5.40;
use feature 'class';
no warnings 'experimental::class';

our $VERSION = '0.01';

class Daje::Generate::Perl::Generate::Class :isa(Daje::Generate::Perl::Base::Common)  {
    use String::CamelCase qw(camelize);

    field $methods :param;
    field $fields :param;
    field $config :param;

    method generate() {
        my $tpl = $self->template->get_data_section('class');
        my $table_name = $self->json->{table_name};
        my $name_space = $config->{CLASS}->{name_space};
        my $base_name_space = $config->{CLASS}->{base_name_space};
        my $class_name = camelize($table_name);
        my $base_class_name = "Base";

        my $select_fields = $methods->select_fields();
        my $pkey = $methods->pkey();
        my $fkey = $methods->fkey();
        my $insert = $methods->insert();
        my $update = $methods->update();

        $tpl =~ s/<<fields>>/$select_fields/ig;
        $tpl =~ s/<<name_space>>/$name_space/ig;
        $tpl =~ s/<<classname>>/$class_name/ig;
        $tpl =~ s/<<base_name_space>>/$base_name_space/ig;
        $tpl =~ s/<<base_class_name>>/$base_class_name/ig;

        $tpl =~ s/<<pkey>>/$pkey/ig;
        $tpl =~ s/<<fkey>>/$fkey/ig;
        $tpl =~ s/<<insert>>/$insert/ig;
        $tpl =~ s/<<update>>/$update/ig;

        return $tpl;
    }

}
1;