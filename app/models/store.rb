class Store < ApplicationRecord
  belongs_to :owner_user
  has_one_attached :image
  has_many :comments
  has_many :reviews, dependent: :destroy

  with_options presence: true do
    validates :name
    validates :image
    validates :adress
    validates :price
    validates :store_time
  end

  def avg_score
    unless self.reviews.empty?
      reviews.average(:score).round(1).to_f
    else
      0.0
    end 
  end 
end
