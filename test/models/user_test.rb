require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should be valid with a valid role" do
    user = User.new(email: "test@example.com", password: "password", password_confirmation: "password", role: "customer")
    assert user.valid?
  end

  test "should be invalid without a role" do
    user = User.new(email: "test@example.com", password: "password", password_confirmation: "password", role: nil)
    assert_not user.valid?
    assert_includes user.errors[:role], " is not a valid role"
  end

  test "should be invalid with an invalid role" do
    user = User.new(email: "test@example.com", password: "password", password_confirmation: "password", role: "admin")
    assert_not user.valid?
    assert_includes user.errors[:role], "admin is not a valid role"
  end

  test "should have secure password" do
    user = User.new(email: "test@example.com", password: "password", password_confirmation: "password", role: "customer")
    assert user.save
    assert user.authenticate("password")
    assert_not user.authenticate("wrong_password")
  end

  test "should have many tickets" do
    user = users(:one) # Assuming you have a fixture named 'one' in users.yml
    assert_respond_to user, :tickets
  end

  test "should have many comments" do
    user = users(:one) # Assuming you have a fixture named 'one' in users.yml
    assert_respond_to user, :comments
  end
end
