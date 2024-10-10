use v5.40;
use feature 'class';
no warnings 'experimental::class';


class Daje::Generate::Base::Common {

    method _load_config () {
        try {
            $config = Config::Tiny->read($config_path);
        } catch ($e) {
            die "Could not load config '$e";
        };

        return;
    }

    method _load_templates($source, $datasections) {
        my $template;
        try {
            $template = Daje::Generate::Tools::Datasections->new(
                data_sections => $datasections,
                source        => $source
            );
            $template->load_data_sections();
        } catch ($e) {
            die "load_templates failed '$e";
        };

        return $template;
    }

}
1;