class User < ApplicationRecord
  has_many :sessions, dependent: :delete_all
  has_many :cards, dependent: :delete_all

  has_secure_password
end
