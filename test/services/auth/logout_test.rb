require 'test_helper'

class LogoutTest < ActiveSupport::TestCase
  def test_when_token_is_not_found_do_nothing
    before_count = Session.count
    result = Auth::Logout.new('unexistant_token').execute

    assert_not(result)
    assert_equal(Session.count, before_count)
  end

  def test_when_token_is_found_remove_it
    user = users(:snake)
    token = 'token'
    user.sessions.create!(token)

    before_count = Session.count
    Auth::Logout.new(token).execute

    assert(Session.count < before_count)
  end
end
