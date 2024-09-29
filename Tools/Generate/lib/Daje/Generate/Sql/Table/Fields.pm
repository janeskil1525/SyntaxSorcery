use v5.40;
use feature 'class';
no warnings 'experimental::class';

# GenerateSQL::Sql::Table::Fields -- create the fields part of a create table script
#
# SYNOPSIS
# ========
#     my $json = from_json( qq (
#         {
#             "fields": {
#                 "userid": "varchar",
#                 "username": "varchar",
#                 "password": "varchar",
#                 "phone": "varchar",
#                 "active": "bigint",
#                 "support": "bigint",
#                 "is_admin": "bigint"
#             }
#         }
#     ));
#
#       my $template = GenerateSQL::Tools::Datasections->new(
#           data_sections => "table,foregin_key,index" ,
#           source        => 'GenerateSQL::Template::Templates'
#       );
#
#       my $fields = GenerateSQL::Sql::Table::Fields->new(
#           json     => $json,
#           template => $template,
#       );
#
#       $fields->create_fields();
#       my $sql = $fields->sql;
#
# METHODS
# =======
#       create_fields() Create the SQL for field creation from JSON
#       get_defaults($datatype) Get defaults part for the sql datatype
#
#
#

class Daje::Generate::Sql::Table::Fields :isa(Daje::Generate::Sql::Base::Common){
    use Syntax::Keyword::Match qw(match);

    method create_fields(){
        my $field = '';
        try {
            my $fields = $self->json->{fields};
            foreach my $key (sort keys %{$fields}) {
                $field .= $key . ' ' . $fields->{$key} . $self->get_defaults($fields->{$key}) . ',';
            }
        } catch ($e) {
            die "Fields could not be generated $e";
        };

        $self->set_sql($field);

        return ;
    }

    method get_defaults($datatype) {
        my $result = "";
        if (index($datatype,'(') > -1) {
            $datatype = substr($datatype,0,index($datatype,'('))
        }
        match(lc($datatype) : eq) {
            case ('bigint') { $result = " not null default 0 \n"}
            case ('smallint') { $result = " not null default 0 \n"}
            case ('integer') { $result = " not null default 0 \n"}
            case ('decimal') { $result = " not null default 0.0 \n"}
            case ('numeric') { $result = " not null default 0.0 \n"}
            case ('varchar') { $result = " not null default '' \n"}
            case ('char') { $result = " not null default '' \n"}
            case ('text') { $result = " not null default '' \n"}
            default { $result = '' }
        }
        return $result;
    }
}
1;







#################### pod generated by Pod::Autopod - keep this line to make pod updates possible ####################

=head1 NAME

lib::Daje::Generate::Sql::Table::Fields - lib::Daje::Generate::Sql::Table::Fields


=head1 SYNOPSIS

    my $json = from_json( qq (
        {
            "fields": {
                "userid": "varchar",
                "username": "varchar",
                "password": "varchar",
                "phone": "varchar",
                "active": "bigint",
                "support": "bigint",
                "is_admin": "bigint"
            }
        }
    ));

      my $template = GenerateSQL::Tools::Datasections->new(
          data_sections => "table,foregin_key,index" ,
          source        => 'GenerateSQL::Template::Templates'
      );

      my $fields = GenerateSQL::Sql::Table::Fields->new(
          json     => $json,
          template => $template,
      );

      $fields->create_fields();
      my $sql = $fields->sql;



=head1 DESCRIPTION

GenerateSQL::Sql::Table::Fields -- create the fields part of a create table script



=head1 REQUIRES

L<Syntax::Keyword::Match> 

L<feature> 

L<v5.40> 


=head1 METHODS

      create_fields() Create the SQL for field creation from JSON
      get_defaults($datatype) Get defaults part for the sql datatype





=cut

