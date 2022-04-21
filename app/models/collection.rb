class Collection < ApplicationRecord
  belongs_to :user
  has_many :cards, dependent: :delete_all
end
