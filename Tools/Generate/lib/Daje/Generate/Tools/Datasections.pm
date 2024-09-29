use v5.40;
use feature 'class';
no warnings 'experimental::class';

# Data::Load::Datasection  - Load and keep data sections from named *.pm
#
# Synopsis
# =========
#
# use GenerateSQL::Tools::Datasections
#
# my $data = GenerateSQL::Tools::Datasections->new(
#       data_sections => ['c1','c2','c3'],
#       source => 'Class::Containing::Datasections
#   )->load_data_sections();
#
# METHODS
# =======
# Get one section of loaded data
# my $c1 = $data->get_data_section('c1');
# Add a section of data
# $data->set_data_section('new_section', 'section data');
# Set a new source
# $data->set_source('New::Source');
# Add a new section to load
# $data->add_data_section('test');
#
#
# LICENSE
# =======
# Generate::Tools::Datasections  (the distribution) is licensed under the same terms as Perl.
#
# AUTHOR
# ======
# Jan Eskilsson
#
# COPYRIGHT
# =========
# Copyright (C) 2024 Jan Eskilsson.
#

our $VERSION = '0.01';

class Daje::Generate::Tools::Datasections {
    use Mojo::Loader qw {data_section};
    use Daje::Generate::Test::Datasections;

    field $data_sections :reader :param;
    field $data_sec :reader = {};
    field $source :reader :param;

    # Load all data_sections
    method load_data_sections() {

        try {
            my @data_sec = split(',', $data_sections) ;
            my $length = scalar @data_sec;
            for(my $i = 0; $i < $length; $i++){
                my $section = $data_sec[$i];
                if (!exists($data_sec->{$section})) {
                    my $sec = data_section($source, $section);
                    $self->set_data_section($section,$sec);
                }
            }
        } catch ($e) {
            die ("Error loading templates: $e");
        };

        return 1;
    }
    # Get one section
    method get_data_section($section) {
        return $data_sec->{$section};
    }
    # Set a section
    method set_data_section($key, $templ) {
        $data_sec->{$key} = $templ;
    }
    # Set Source
    method set_source($source_class) {
        $source = $source_class;
    }
    # Add a section to the data sections_array to be loaded
    method add_data_section($section) {
        $data_sections .','. $section;
    }


}
__DATA__

@@ test1

This is a sample text used for testing

@@ test2

This is also a sample text used for testing

__END__
1;







#################### pod generated by Pod::Autopod - keep this line to make pod updates possible ####################

=head1 NAME

lib::Daje::Generate::Tools::Datasections - lib::Daje::Generate::Tools::Datasections


=head1 DESCRIPTION

Data::Load::Datasection  - Load and keep data sections from named *.pm



=head1 REQUIRES

L<Daje::Generate::Test::Datasections> 

L<Mojo::Loader> 

L<feature> 

L<v5.40> 


=head1 METHODS

Get one section of loaded data
my $c1 = $data->get_data_section('c1');
Add a section of data
$data->set_data_section('new_section', 'section data');
Set a new source
$data->set_source('New::Source');
Add a new section to load
$data->add_data_section('test');




=head1 Synopsis


use GenerateSQL::Tools::Datasections

my $data = GenerateSQL::Tools::Datasections->new(
      data_sections => ['c1','c2','c3'],
      source => 'Class::Containing::Datasections
  )->load_data_sections();



=head1 AUTHOR

Jan Eskilsson



=head1 COPYRIGHT

Copyright (C) 2024 Jan Eskilsson.



=head1 LICENSE

Generate::Tools::Datasections  (the distribution) is licensed under the same terms as Perl.



=cut

