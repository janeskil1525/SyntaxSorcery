use v5.40;
use feature 'class';
no warnings 'experimental::class';

our $VERSION = '0.01';

class Daje::Generate::Perl::Generate::Fields :isa(Daje::Generate::Perl::Base::Common) {
    field $select :reader = "";
    field $primary_key :reader = "";
    field $foreign_keys :reader = ();

    method generate() {
       $self->_get_fields();


    }

    method _get_fields() {
        my $column_names = $self->json->{column_names};
        my $length = scalar @{$column_names};
        for (my $i = 0; $i < $length; $i++) {
            if (index(@{$column_names}[$i]->{column_name},'_pkey') > -1){
                $primary_key = @{$column_names}[$i]->{column_name};
            }
            if (index(@{$column_names}[$i]->{column_name},'_fkey') > -1){
                push (@{$foreign_keys}, @{$column_names}[$i]->{column_name});
            }
            if (length($select) > 0) {
                $select .= ', ' . @{$column_names}[$i]->{column_name};
            } else {
                $select = @{$column_names}[$i]->{column_name};
            }
        }
    }
}

1;