use utf8;
package Namespace::Schema::Result::Linguage;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Namespace::Schema::Result::Linguage

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<linguage>

=cut

__PACKAGE__->table("linguage");

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

=head1 RELATIONS

=head2 books

Type: has_many

Related object: L<Namespace::Schema::Result::Book>

=cut

__PACKAGE__->has_many(
  "books",
  "Namespace::Schema::Result::Book",
  { "foreign.linguage_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07047 @ 2018-03-04 06:40:37
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:MATudHNi+HYt0OmZUyKt1g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
