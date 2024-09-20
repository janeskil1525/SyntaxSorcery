use v5.40;
use feature 'class';
no warnings 'experimental::class';

class Generate::Sql::Table::ForeignKey :isa(Generate::Sql::Base::Common){
    field $tablename :param = "";
    field $templates :reader = {};
    field $created :reader = 0;
    method create_foreign_keys() {
        my $fkeys = '';
        $templates->{template_fkey} = "";
        $templates->{template_ind} = "";
        try {
            my $fields = $self->json->{fields};
            foreach my $key (sort keys %{$fields}) {
                if (index($key,'_fkey') > -1) {
                    my ($template_fkey,$template_ind) = $self->get_templates($key);
                    my $referenced_table = substr($key,0,index($key,'_fkey'));
                    $templates->{template_fkey} .= $template_fkey;
                    $templates->{template_ind} .= $template_ind;
                    $created = 1;
                }
            }
        } catch ($e) {
            die "Foreign keys could not be created $e";
        };
        return;
    }

    method get_templates($key) {
        my $referenced_table = substr($key,0,index($key,'_fkey'));
        my $template_fkey = $self->template->get_data_section('foreign_key');
        $template_fkey =~ s/<<referenced_table>>/$referenced_table/ig;
        my $template_ind = $self->template->get_data_section('index');
        $template_ind =~ s/<<type>>//ig;
        $template_ind =~ s/<<table>>/$tablename/ig;
        $template_ind =~ s/<<field_names>>/$key/ig;
        $template_ind =~ s/<<fields>>/$key/ig;
        $created = 1;

        return ($template_fkey,$template_ind);
    }
}
1;



#################### pod generated by Pod::Autopod - keep this line to make pod updates possible ####################

=head1 NAME

lib::GenerateSQL::Sql::Table::ForeginKey - lib::GenerateSQL::Sql::Table::ForeginKey


=head1 DESCRIPTION

pod generated by Pod::Autopod - keep this line to make pod updates possible ####################


=head1 REQUIRES

L<feature> 

L<v5.40> 


=head1 METHODS


=cut
