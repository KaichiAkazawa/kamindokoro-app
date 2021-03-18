class StoresTag
  include ActiveModel::Model
  attr_accessor :name, :image, :address, :station, :price, :store_time, :link, :owner_user_id, :word

  with_options presence: true do
    validates :name
    validates :image
    validates :address
    validates :station
    validates :price, numelicality: { only_integer: true }
    validates :store_time
  end
    validates :url, format: /\A#{URI::regexp(%w(http https))}\z/

  # レコードの有無で新規作成or更新を分岐
  delegate :persisted?, to: :store

  def initialize(attributes = nil, store: Store.new)
    @store = store
    attributes ||= default_attributes
    super(attributes)
  end

  def save(tag_list)
    ActiveRecord::Base.transaction do
      @store.update(name: name, image: image, address: address, station: station, price: price, store_time: store_time,
                          link: link, owner_user_id: owner_user_id)

      @store.store_tag_relations.each do |tag|
        tag.delete
      end

      tag_list.each do |word|
        tag = Tag.where(word: word).first_or_initialize
        tag.save
        
        store_tag = StoreTagRelation.where(store_id: @store.id, tag_id: tag.id).first_or_initialize
        store_tag.update(store_id: @store.id, tag_id: tag.id)
      end
    end
  end

  def to_model
    store
  end

  private

  attr_reader :store

  def default_attributes
    {
      name: store.name,
      image: store.image,
      address: store.address,
      station: store.station,
      price: store.price,
      store_time: store.store_time,
      link: store.link,
      word: store.tags.pluck(:word).join(',')
    }
  end
end
