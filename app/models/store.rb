class Store < ApplicationRecord
  belongs_to :owner_user
  has_one_attached :image
  has_many :comments
  has_many :reviews, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :store_tag_relations
  has_many :tags, through: :store_tag_relations

  def avg_score
    if reviews.empty?
      0.0
    else
      reviews.average(:score).round(1).to_f
    end
  end

  def self.store_search(search)
    if search != ''
      Store.where('name LIKE(?) OR station LIKE(?) OR adress LIKE(?)', "%#{search}%", "%#{search}%", "%#{search}%")
    else
      Store.all
    end
  end
end
