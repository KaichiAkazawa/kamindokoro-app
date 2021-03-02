class Bookmark < ApplicationRecord
  belongs_to :customer_user
  belongs_to :store
end
