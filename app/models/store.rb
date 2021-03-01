class Store < ApplicationRecord
  belongs_to :owner_user
  has_one_attached :image
  has_many :comments

  with_options presence: true do
    validates :name
    validates :image
    validates :adress
    validates :price
    validates :store_time
  end
end
