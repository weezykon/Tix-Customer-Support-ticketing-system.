require 'test_helper'
require './app/graphql/types/user_type' # Make sure to require the type file
require './app/graphql/types/ticket_type'
require './app/graphql/types/comment_type'

class Types::UserTypeTest < ActiveSupport::TestCase
  test "UserType has the correct fields" do
    fields = Types::UserType.fields.keys

    assert_includes fields, "id"
    assert_includes fields, "name"
    assert_includes fields, "email"
    assert_includes fields, "role"
    assert_includes fields, "tickets"
    assert_includes fields, "comments"
  end

  test "UserType fields have correct types" do
    assert_equal GraphQL::Types::ID, Types::UserType.fields["id"].type.of_type
    assert_equal GraphQL::Types::String, Types::UserType.fields["name"].type.of_type
    assert_equal GraphQL::Types::String, Types::UserType.fields["email"].type.of_type
    assert_equal GraphQL::Types::String, Types::UserType.fields["role"].type.of_type
    assert_equal Types::TicketType, Types::UserType.fields["tickets"].type.of_type.of_type
    assert_equal Types::CommentType, Types::UserType.fields["comments"].type.of_type.of_type
  end
end
