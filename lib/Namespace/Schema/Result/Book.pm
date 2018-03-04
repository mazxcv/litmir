use utf8;
package Namespace::Schema::Result::Book;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Namespace::Schema::Result::Book

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<book>

=cut

__PACKAGE__->table("book");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 link

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 image_path

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 author_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 genre_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 age

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 linguage_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 count_pages

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 created

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 255 },
  "link",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 255 },
  "image_path",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 255 },
  "author_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "genre_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "age",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 255 },
  "linguage_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "count_pages",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 255 },
  "created",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<name_author_genre_linguage>

=over 4

=item * L</author_id>

=item * L</genre_id>

=item * L</linguage_id>

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "name_author_genre_linguage",
  ["author_id", "genre_id", "linguage_id", "name"],
);

=head1 RELATIONS

=head2 author

Type: belongs_to

Related object: L<Namespace::Schema::Result::Author>

=cut

__PACKAGE__->belongs_to(
  "author",
  "Namespace::Schema::Result::Author",
  { id => "author_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "SET NULL",
    on_update     => "CASCADE",
  },
);

=head2 genre

Type: belongs_to

Related object: L<Namespace::Schema::Result::Genre>

=cut

__PACKAGE__->belongs_to(
  "genre",
  "Namespace::Schema::Result::Genre",
  { id => "genre_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "SET NULL",
    on_update     => "CASCADE",
  },
);

=head2 linguage

Type: belongs_to

Related object: L<Namespace::Schema::Result::Linguage>

=cut

__PACKAGE__->belongs_to(
  "linguage",
  "Namespace::Schema::Result::Linguage",
  { id => "linguage_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "SET NULL",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07047 @ 2018-03-04 09:49:45
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:bTwiNFviG3uqYg7A8Jd52g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
