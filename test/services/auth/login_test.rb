require 'test_helper'

class LoginTest < ActiveSupport::TestCase
  def test_when_user_does_not_exist_dont_create_session
    before_count = Session.count
    result = Auth::Login.new('asdf@example.com', 'mypassword').execute

    assert_not(result)
    assert_equal(Session.count, before_count)
  end

  def test_when_wrong_password_dont_create_session
    user = users(:snake)

    before_count = Session.count
    result = Auth::Login.new(user.email, 'wrong_password').execute

    assert_not(result)
    assert_equal(Session.count, before_count)
  end

  def test_when_all_good_create_session
    user = User.create(
      email: 'allgood@email.com',
      password: 'pass',
      password_confirmation: 'pass'
    )

    before_count = Session.count
    result = Auth::Login.new(user.email, 'pass').execute

    assert(Session.count > before_count)
    assert(result)
  end

  def test_token_expires
    user = User.create(
      email: 'allgood@email.com',
      password: 'pass',
      password_confirmation: 'pass'
    )

    result = Auth::Login.new(user.email, 'pass').execute

    assert(result.expires_at > Time.zone.now)
    assert(result.expires_at < Session::EXPIRE_TIME.from_now)
  end
end
