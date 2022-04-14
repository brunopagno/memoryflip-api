class Session < ApplicationRecord
  belongs_to :user

  EXPIRE_TIME = 1.week
  COOKIE_NAME = 'session'.freeze
  LOGIN_COOKIE_NAME = 'login_ok'.freeze
end
