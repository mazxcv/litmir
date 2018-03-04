#!/usr/bin/env perl

use strict;
use warnings;
use utf8;

use DBI;
use Data::Dumper;

my $conf = do './mysq.conf';

my $dsn = "DBI:mysql:database=$conf->{database};host=$conf->{host};port=$conf->{port}";
my $dbh = DBI->connect($dsn, $conf->{user}, $conf->{password});


$dbh->do("drop table if exists book");
$dbh->do("drop table if exists author");
$dbh->do("drop table if exists genre");
$dbh->do("drop table if exists linguage");

$dbh->do("
	create table author(
		id int(11) not null primary key auto_increment, 
		name varchar(255) not null default '', 
		created timestamp not null default current_timestamp
	)engine=InnoDB default charset=utf8;
");

$dbh->do("
	create table genre(
		id int(11) not null primary key auto_increment, 
		name varchar(255) not null default '', 
		created timestamp not null default current_timestamp
	)engine=InnoDB default charset=utf8;
");


$dbh->do("
	create table linguage(
		id int(11) not null primary key auto_increment, 
		name varchar(255) not null default '', 
		created timestamp not null default current_timestamp
	)engine=InnoDB default charset=utf8;
");

$dbh->do("
	create table book(
		id int(11) not null primary key auto_increment, 
		name varchar(255) not null default '', 
		link varchar(255) not null default '', 
		image_path varchar(255) not null default '', 
		author_id int(11), 
		genre_id int(11), 
		age varchar(255) not null default '', 
		linguage_id int(11), 
		count_pages varchar(255) not null default '', 
		created timestamp not null default current_timestamp,
		foreign key(author_id) references author(id) on delete set null on update cascade,
		foreign key(genre_id) references genre(id) on delete set null on update cascade,
		foreign key(linguage_id) references linguage(id) on delete set null on update cascade,
		unique key name_author_genre_linguage(author_id, genre_id, linguage_id, name)
	)engine=InnoDB default charset=utf8;
");

$dbh->disconnect();
