package Daje::Generate::Templates::Perl;
use v5.40;

1;

__DATA__

@@ class
use v5.40;
use feature 'class';
no warnings 'experimental::class';

# Autogenerated class <<date>>
# Any manual changes to this class will be overwritten next time its generated

class <<namespace>><<classname>> :isa(<<namespace>>::Base::Database) {

    <<fields>>

    <<methods>>


};

@@ method

    method <<method_name>> ($self, <<parameters>>) {
        <<method_content>>
    };


@@ baseclass
use v5.40;
use feature 'class';
no warnings 'experimental::class';

# Autogenerated class <<date>>
# Any manual changes to this class will be overwritten next time its generated

class <<namespace>>::Base::Database {
    field $db :param :reader;


};