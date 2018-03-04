package App;
use Mojo::Base 'Mojolicious';
use Mojo::Log;
use Namespace::Schema;

use Data::Dumper;

has schema => sub {
	my $conf = do "./mysq.conf";

	return Namespace::Schema->connect(
			"dbi:mysql:$conf->{database}:$conf->{host}:$conf->{port}",
			$conf->{user},
			$conf->{password},
			{
				quote_names => 1,
				mysql_enable_utf8 => 1
			}
		);
};


sub startup {
	my $self   = shift;
	my $config = $self->plugin('Config');
	$self->config($config);
	my $env    = $config->{mode};
	$self->app->log(Mojo::Log->new(path => "log/$env.log", level => $config->{log_level}));
	$self->helper(db => sub {$self->app->schema});

	my $r = $self->routes;
	$r->get('/')->to('start#hello');
	$r->get('/list')->to("start#list");
	$r->post('/remove')->to("start#remove");

	$r->route('/litmir')->to('litmir#get_url');
	$r->get('/get_json')->to('litmir#get_json');
	
}

1;
