class Tag < ApplicationRecord
  has_many :store_tag_relations
  has_many :stores, through: :store_tag_relations

  validates :word, uniqueness: true
end
