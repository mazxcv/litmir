package App::Litmir;
use Mojo::Base 'Mojolicious::Controller';
use Mojo::URL;
use JSON;
use Mojo::DOM;
use Mojo::Promise;
use Mojo::IOLoop;

use DDP;
use Data::Dumper;

sub get_json {
	my $self = shift;

	return $self->render( 
		json => [ 
			$self->_book->search(
				undef, 
				{
					prefetch => [qw/author genre linguage/],
					result_class => 'DBIx::Class::ResultClass::HashRefInflator'
				}
			)->all ]
	);
}


sub parse {
	my $self = shift;
	my $url_string = shift or return {status => 'not ok'};;
	my $url  = Mojo::URL->new($url_string);
	my $step = 0+$url->query->param('p');
	my $near_url = +{map {my $url = $url->clone; $url->query->merge(p => $step + $_);$_ => $url } 0 .. 9};
	for (0 .. 9) {
		my $this_url = $near_url->{$_};
		$self->promise($near_url->{$_})->then(sub {
				$self->app->log->info("Fetch url:$this_url");
				my $tx = shift;
				for my $dom ($tx->res->dom('table.island')->each) {
					my $desc_conatiner = eval { $dom->find('.desc_container .desc_box')->last->previous };
					my $author         = eval { $dom->at('[itemprop=author] a')->text      } || '';
					my $genre          = eval { $dom->at('[itemprop=genre] a')->text       } || '';
					my $linguage       = eval { $desc_conatiner->find('.desc2')->[1]->text } || '';
					my $book = {
						image_path => eval { $dom->at('[jq=BookCover]')->attr('data-src') } || '',
						name       => eval { $dom->at('[itemprop=name]')->text            } || '',
						link       => eval { $dom->at('.book_name a')->attr('href')       } || '',
						age        => eval { $desc_conatiner->find('.desc2 a')->[0]->text } || 0,
						count_pages=> eval { $desc_conatiner->find('.desc2')->[2]->text   } || 0,
					};

					$book->{author_id}   = $self->_author()  ->find_or_create({name => $author},   {})->id;
					$book->{genre_id}    = $self->_genre()   ->find_or_create({name => $genre},    {})->id;
					$book->{linguage_id} = $self->_linguage()->find_or_create({name => $linguage}, {})->id;

					$self->_book()->find_or_create($book, $book);

					$self->app->log->info("Fetch book:$book->{name}");
				}

				return 0;
			})->wait;
	}

	return {status => 'ok'};
}


sub promise {
	my ($self, $url) = @_;
	my $promise = Mojo::Promise->new;
	shift->ua->get($url => sub {
			my ($ua, $tx) = @_;
			my $err = $tx->error;
			$promise->resolve($tx) if !$err;
			$promise->reject($err->{message});
		});
	return $promise;
}


sub get_url {
	my $self = shift;
	my $p    = $self->req->params->to_hash;
	my $data = $self->parse($p->{search});

	return $self->render(json => $data);
}

sub _book { shift->db->resultset('Book') }

sub _author { shift->db->resultset('Author') }

sub _genre { shift->db->resultset('Genre') }

sub _linguage { shift->db->resultset('Linguage') }

1;