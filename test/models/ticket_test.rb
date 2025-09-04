require 'test_helper'

class TicketTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @agent = users(:two)
  end

  test "should be valid with a valid status" do
    ticket = Ticket.new(title: "Test Ticket", description: "This is a test ticket.", status: "open", user: @user)
    assert ticket.valid?
  end

  test "should be invalid without a status" do
    ticket = Ticket.new(title: "Test Ticket", description: "This is a test ticket.", status: nil, user: @user)
    assert_not ticket.valid?
    assert_includes ticket.errors[:status], " is not a valid status"
  end

  test "should be invalid with an invalid status" do
    ticket = Ticket.new(title: "Test Ticket", description: "This is a test ticket.", status: "invalid", user: @user)
    assert_not ticket.valid?
    assert_includes ticket.errors[:status], "invalid is not a valid status"
  end

  test "should belong to a user" do
    ticket = tickets(:one) # Assuming you have a fixture named 'one' in tickets.yml
    assert_respond_to ticket, :user
    assert_equal users(:one), ticket.user
  end

  test "should optionally belong to an assigned agent" do
    ticket = tickets(:one) # Assuming you have a fixture named 'one' in tickets.yml
    assert_respond_to ticket, :assigned_agent
    assert_nil ticket.assigned_agent # Assuming fixture 'one' doesn't have an assigned agent
  end

  test "should have many comments" do
    ticket = tickets(:one) # Assuming you have a fixture named 'one' in tickets.yml
    assert_respond_to ticket, :comments
  end

  test "self.to_csv should generate CSV data" do
    # Create some test tickets
    Ticket.create(title: "Ticket 1", description: "Desc 1", status: "open", user: @user)
    Ticket.create(title: "Ticket 2", description: "Desc 2", status: "closed", user: @user, assigned_agent: @agent)

    csv_data = Ticket.to_csv
    assert_not_nil csv_data
    assert_match /id,title,description,status,user_id,assigned_agent_id,created_at,updated_at/, csv_data
    assert_match /Ticket 1,Desc 1,open/, csv_data
    assert_match /Ticket 2,Desc 2,closed/, csv_data
  end
end