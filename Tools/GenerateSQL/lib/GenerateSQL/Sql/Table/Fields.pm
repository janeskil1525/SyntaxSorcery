use v5.40;
use feature 'class';
no warnings 'experimental::class';


class GenerateSQL::Sql::Table::Fields :isa(GenerateSQL::Sql::Base::Common){
    use Syntax::Keyword::Match qw(match);

    method create_fields(){
        my $ressult = '';
        my $fields = $self->json->{fields};
        while (my ($key, $value) = each %{$fields}) {
            $ressult .= $key . ' ' . $value . $self->get_defaults($value) . ',';
        }
        return $ressult;
    }

    method get_defaults($datatype) {
        my $result = "";
        match($datatype : eq) {
            case('bigint') { $result = " not null default 0 \n"}
            case ('varchar') { $result = " not null default '' \n"}
            default { $result = '' }

        }
        return $result;
    }
}
1;
#################### pod generated by Pod::Autopod - keep this line to make pod updates possible ####################

=head1 NAME

lib::GenerateSQL::Sql::Table::Fields - lib::GenerateSQL::Sql::Table::Fields


=head1 REQUIRES

L<Syntax::Keyword::Match> 

L<feature> 

L<v5.40> 


=head1 METHODS


=cut
