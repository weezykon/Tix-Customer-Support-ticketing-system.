require 'test_helper'
require './app/graphql/types/comment_type'
require './app/graphql/types/user_type'
require './app/graphql/types/ticket_type'

class Types::CommentTypeTest < ActiveSupport::TestCase
  test "CommentType has the correct fields" do
    fields = Types::CommentType.fields.keys

    assert_includes fields, "id"
    assert_includes fields, "content"
    assert_includes fields, "user"
    assert_includes fields, "ticket"
  end

  test "CommentType fields have correct types" do
    assert_equal GraphQL::Types::ID, Types::CommentType.fields["id"].type.of_type
    assert_equal GraphQL::Types::String, Types::CommentType.fields["content"].type.of_type
    assert_equal Types::UserType, Types::CommentType.fields["user"].type.of_type
    assert_equal Types::TicketType, Types::CommentType.fields["ticket"].type.of_type
  end
end
