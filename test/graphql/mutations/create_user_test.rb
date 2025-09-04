require 'test_helper'
require 'minitest/mock' # Add this line
require './app/graphql/mutations/create_user'
require './app/graphql/tix_app_schema'

class Mutations::CreateUserTest < ActiveSupport::TestCase
  test "create user with valid arguments" do
    # Mock the context object to provide a schema with a types method
    mock_context = Minitest::Mock.new
    mock_context.expect(:schema, TixAppSchema)

    mutation = Mutations::CreateUser.new(field: nil, object: nil, context: mock_context)
    result = mutation.resolve(name: "Test User", email: "test@example.com", role: "customer")

    assert_not_nil result[:user]
    assert_equal "Test User", result[:user].name
    assert_equal "test@example.com", result[:user].email
    assert_equal "customer", result[:user].role
    assert_empty result[:errors]
  end

  test "fail to create user with invalid role" do
    mock_context = Minitest::Mock.new
    mock_context.expect(:schema, TixAppSchema)

    mutation = Mutations::CreateUser.new(field: nil, object: nil, context: mock_context)
    result = mutation.resolve(name: "Invalid User", email: "invalid@example.com", role: "invalid_role")

    assert_nil result[:user]
    assert_not_empty result[:errors]
    assert_includes result[:errors], "Role invalid_role is not a valid role"
  end
end