package App::Start;
use Mojo::Base 'Mojolicious::Controller';

use DDP;


sub hello {
	return shift->render();
}


sub remove {
	my $self = shift;
	my $p    = $self->req->params->to_hash;
	$self->_book()->find({id => $p->{id}})->delete;
	
	return $self->render(json => {status => 'ok'});
}

sub list {
	my $self = shift;

	my $litmir = "https://www.litmir.me";

	my $list = [ 
		map {
			{
				id          => $_->{id},
				name        => $_->{name},
				link        => $litmir . $_->{link},
				image_path  => $litmir . $_->{image_path},
				author      => $_->{author}->{name},
				genre       => $_->{genre}->{name},
				age         => $_->{age},
				linguage    => $_->{linguage}->{name},
				count_pages => $_->{count_pages}
			}
		} 
		($self->_book->search(
			undef, 
			{
				prefetch => [qw/author genre linguage/],
				result_class => 'DBIx::Class::ResultClass::HashRefInflator'
			}
		)->all) 
	];
	return $self->render(
		list => $list
	);
}

sub _book { shift->db->resultset('Book') }

1;