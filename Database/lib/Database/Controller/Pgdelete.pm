package Database::Controller::Pgdelete;
use Mojo::Base 'Database::Controller::BaseController';

use Database::Helper::Common;

sub delete($self) {

    $self->render_later;
    my $data = Database::Helper::Common->new($self)->get_basedata();
}
1;