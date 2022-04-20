class User < ApplicationRecord
  has_many :sessions, dependent: :delete_all
  has_many :collections, dependent: :delete_all
  has_many :cards, through: :collections

  has_secure_password
end
