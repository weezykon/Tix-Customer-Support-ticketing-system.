require 'test_helper'
require './app/graphql/types/ticket_type'
require './app/graphql/types/user_type'
require './app/graphql/types/comment_type'

class Types::TicketTypeTest < ActiveSupport::TestCase
  test "TicketType has the correct fields" do
    fields = Types::TicketType.fields.keys

    assert_includes fields, "id"
    assert_includes fields, "title"
    assert_includes fields, "description"
    assert_includes fields, "status"
    assert_includes fields, "user"
    assert_includes fields, "assignedAgent"
    assert_includes fields, "comments"
  end

  test "TicketType fields have correct types" do
    assert_equal GraphQL::Types::ID, Types::TicketType.fields["id"].type.of_type
    assert_equal GraphQL::Types::String, Types::TicketType.fields["title"].type.of_type
    assert_equal GraphQL::Types::String, Types::TicketType.fields["description"].type.of_type
    assert_equal GraphQL::Types::String, Types::TicketType.fields["status"].type.of_type

    # For non-nullable fields, type is GraphQL::Schema::NonNull(ActualType)
    assert_equal Types::UserType, Types::TicketType.fields["user"].type.of_type

    # For nullable fields, type is ActualType
    assert_equal Types::UserType, Types::TicketType.fields["assignedAgent"].type

    # For list fields, type is GraphQL::Schema::List(ActualType)
    assert_equal Types::CommentType, Types::TicketType.fields["comments"].type.of_type.of_type
  end
end
