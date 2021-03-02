class Review < ApplicationRecord
  belongs_to :customer_user
  belongs_to :store

  validates :score, presence: true
end
