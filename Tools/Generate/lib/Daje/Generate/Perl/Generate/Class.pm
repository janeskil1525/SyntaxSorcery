use v5.40;
use feature 'class';
no warnings 'experimental::class';

our $VERSION = '0.01';

class Daje::Generate::Perl::Generate::Class :isa(Daje::Generate::Perl::Base::Common)  {
    use String::CamelCase qw(camelize);

    field $methods;
    field $fields;
    field $config :param;

    method generate() {
        my $tpl = $self->template->get_data_section('class');
        my $table_name = $self->json->{table_name};
        my $name_space = $config->{CLASS}->{name_space};
        my $base_name_space = $config->{CLASS}->{base_name_space};
        my $class_name = camelize($table_name);
        my $base_class_name = "Base";
        my $search_fields = $fields->select();

        $tpl =~ s/<<fields>>/$search_fields/ig;
        $tpl =~ s/<<name_space>>/$name_space/ig;
        $tpl =~ s/<<classname>>/$class_name/ig;
        $tpl =~ s/<<base_name_space>>/$base_name_space/ig;
        $tpl =~ s/<<pkey>>/$base_class_name/ig;
        $tpl =~ s/<<fkey>>/$base_class_name/ig;
        $tpl =~ s/<<insert>>/$base_class_name/ig;
        $tpl =~ s/<<update>>/$base_class_name/ig;

        return $tpl;
    }

}
1;