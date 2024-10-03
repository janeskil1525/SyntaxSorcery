package Database::Controller::Pglist;
use Mojo::Base 'Database::Controller::BaseController';

use List::MoreUtils qw { first_index };
use Database::Helper::Common;
use Database::Model;

sub list($self) {
    $self->render_later;

    my $err;
    my $index;
    my $table = $self->param('table');
    my $data = $self->get_basedata();

    $self->pgmodel->list_p($data, $table)->then(sub($result) {
        $self->render(json => { 'result' => 'success', data => $result });
     })->catch(sub($err) {
         $self->render(json => { 'result' => 'failed', data => $err });
     })->wait();
}

1;