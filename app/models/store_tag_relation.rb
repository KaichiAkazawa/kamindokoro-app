class StoreTagRelation < ApplicationRecord
  belongs_to :store
  belongs_to :tag
end
