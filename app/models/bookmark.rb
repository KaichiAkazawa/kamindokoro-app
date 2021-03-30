class Bookmark < ApplicationRecord
  belongs_to :customer_user
  belongs_to :store

  validates_uniqueness_of :store_id, scope: :customer_user_id
end
