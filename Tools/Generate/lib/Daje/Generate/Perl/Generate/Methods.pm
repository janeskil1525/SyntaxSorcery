use v5.40;
use feature 'class';
no warnings 'experimental::class';


class Daje::Generate::Perl::Generate::Methods :isa(Daje::Generate::Perl::Base::Common) {
    field $fields :param :reader;
    field $pkey :reader;
    field $fkey :reader;

    method generate() {
        $pkey = $self->_get_pkey();
        $fkey = $self->_get_fkey()

    }

    method _get_fkey() {
        my $load_from_fkey = "";
        my $f_key = $fields->foregin_keys();
        my $table_name = $self->json->{table_name};
        my $select = $fields->select();
        my $length = scalar @{$f_key};

        for (my $i = 0; $i < $length; $i++) {
            my $tpl = $self->template->get_data_section('load_from_fkey');
            $tpl =~ s/<<foreign_key>>/$f_key/ig;
            $tpl =~ s/<<table_name>>/$table_name/ig;
            $tpl =~ s/<<select_fields>>/$select/ig;
            $load_from_fkey .= $tpl ."\n\n";
        }
        return $load_from_fkey;
    }

    method _get_pkey(){
        my $load_from_pkey = $self->template->get_data_section('load_from_pkey');
        my $p_key = $fields->primary_key();
        my $select = $fields->select();
        my $table_name = $self->json->{table_name};
        $load_from_pkey =~ s/<<primary_key>>/$p_key/ig;
        $load_from_pkey =~ s/<<table_name>>/$table_name/ig;
        $load_from_pkey =~ s/<<select_fields>>/$select/ig;
        return $load_from_pkey;
    }
}
1;