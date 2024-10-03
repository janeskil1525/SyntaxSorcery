use v5.40;
use feature 'class';
no warnings 'experimental::class';

class Daje::Generate::Sql::Table::Index :isa(Daje::Generate::Sql::Base::Common){
    field $tablename :param = "";

    method create_index {
        my $sql = "";
        my $json = $self->json->{index};
        my $length = scalar @{$json};
        for (my $i = 0; $i < $length; $i++) {
            my $template = $self->template->get_data_section('index');
            $template =~ s/<<table>>/$tablename/ig;
            $template =~ s/<<type>>/@{$json}[$i]->{type}/ig;
            $template =~ s/<<fields>>/@{$json}[$i]->{fields}/ig;
            @{$json}[$i]->{fields} =~ s/,/_/ig;
            $template =~ s/<<field_names>>/@{$json}[$i]->{fields}/ig;
            $sql .= $template . "\n\n";
        }
        $self->set_sql($sql);
        return;
    }
}
1;

#################### pod generated by Pod::Autopod - keep this line to make pod updates possible ####################

=head1 NAME

lib::Daje::Generate::Sql::Table::Index - lib::Daje::Generate::Sql::Table::Index


=head1 DESCRIPTION

pod generated by Pod::Autopod - keep this line to make pod updates possible ####################


=head1 REQUIRES

L<feature> 

L<v5.40> 


=head1 METHODS


=cut

