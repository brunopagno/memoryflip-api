class Session < ApplicationRecord
  belongs_to :user

  EXPIRE_TIME = 1.week
  TOKEN_NAME = 'X-Session-Token'.freeze
  TOKEN_EXPIRED = 'token_expired'.freeze
end
