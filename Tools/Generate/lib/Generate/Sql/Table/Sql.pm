use v5.40;
use feature 'class';
no warnings 'experimental::class';


class Generate::Sql::Table::Sql :isa(Generate::Sql::Base::Common) {
    use Syntax::Keyword::Match qw(match);
    field $tablename :param = "";

    method create_sql() {
        my $sql = "";
        my $json = $self->json->{sql};
        my $length = scalar @{$json};
        for (my $i = 0; $i < $length; $i++) {
            my $type = $self->template->get_section(@{$json}[$i]->{type});
            my $template = $self->template->get_section($type);

            match ($type : eq) {
                case('insert') {
                    $template =~ s/<<tablename>>/$tablename/ig;
                    $template =~ s/<<fields>>/@{$json}[$i]->{fields}/ig;
                    $template =~ s/<<values>>/@{$json}[$i]->{values}/ig;
                }
                default { $template = "" }
            }
            $sql .= $template . '\n';
        }
        $self->set_sql($sql);
        return;
    }
}
1;