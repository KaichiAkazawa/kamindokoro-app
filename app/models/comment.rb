class Comment < ApplicationRecord
  belongs_to :customer_user
  belongs_to :store

  validates :text, presence: true
end
