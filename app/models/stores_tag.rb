class StoresTag
  include ActiveModel::Model
  attr_accessor :name, :image, :adress, :station, :price, :store_time, :link, :owner_user_id, :word

  with_options presence: true do
    validates :name
    validates :image
    validates :adress
    validates :price
    validates :store_time
  end

  def save
    tag = Tag.where(word: word).first_or_initialize
    tag.save
    store = Store.create(name: name, image: image, adress: adress, station: station, price: price, store_time: store_time, link: link, owner_user_id: owner_user_id)
    StoreTagRelation.create(store_id: store.id, tag_id: tag.id)
  end
end