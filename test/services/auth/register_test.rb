require 'test_helper'

class RegisterTest < ActiveSupport::TestCase
  def test_when_mistmatched_passwords_dont_create_user
    assert_raises ActiveRecord::RecordInvalid do
      before_count = User.count
      Auth::Register.new('asdf@example.com', 'asdf', 'asdff').execute

      assert_equal(User.count, before_count)
    end
  end

  def test_when_email_already_registered_dont_create_user
    user = users(:snake)

    assert_raises ActiveRecord::RecordNotUnique do
      before_count = User.count
      Auth::Register.new(user.email, 'asdf', 'asdf').execute

      assert_equal(User.count, before_count)
    end
  end

  def test_when_everything_good_create_user_with_hashed_password
    before_count = User.count
    password = 'asdf'
    result = Auth::Register.new('asdf@example.com', password, password).execute

    assert(User.count > before_count)
    assert_not_equal(password, result.password_digest)
  end
end
