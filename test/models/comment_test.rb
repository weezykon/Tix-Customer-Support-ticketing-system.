require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "should belong to a ticket" do
    comment = comments(:one) # Assuming you have a fixture named 'one' in comments.yml
    assert_respond_to comment, :ticket
    assert_equal tickets(:one), comment.ticket
  end

  test "should belong to a user" do
    comment = comments(:one) # Assuming you have a fixture named 'one' in comments.yml
    assert_respond_to comment, :user
    assert_equal users(:one), comment.user
  end
end