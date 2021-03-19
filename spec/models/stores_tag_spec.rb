require 'rails_helper'

RSpec.describe StoresTag, type: :model do
  before do
    owner_user = FactoryBot.create(:owner_user)
    @stores_tag = FactoryBot.build(:stores_tag, owner_user_id: owner_user.id)
  end

  describe '新規店舗登録できる' do
    it '必要な情報を入力すれば登録できる' do
      expect(@stores_tag).to be_valid
    end
    it 'リンクが空でも登録できる' do
      @stores_tag.link = ""
      expect(@stores_tag).to be_valid
    end
  end

  describe '新規店舗登録できない' do
    it 'nameが空では登録できない' do 
      @stores_tag.name = ""
      @stores_tag.valid?
      expect(@stores_tag.errors.full_messages).to include("店舗名を入力してください")
    end
    it 'imageが空では登録できない' do 
      @stores_tag.image = nil
      @stores_tag.valid?
      expect(@stores_tag.errors.full_messages).to include("写真を添付してください")
    end
    it 'addressが空では登録できない' do
      @stores_tag.address = ""
      @stores_tag.valid?
      expect(@stores_tag.errors.full_messages).to include("住所を入力してください")
    end
    it 'stationが空では登録できない' do
      @stores_tag.station = ""
      @stores_tag.valid?
      expect(@stores_tag.errors.full_messages).to include("最寄駅を入力してください")
    end
    it 'priceが空では登録できない' do
      @stores_tag.price = ""
      @stores_tag.valid?
      expect(@stores_tag.errors.full_messages).to include("料金を入力してください")
    end
    it 'priceが数値以外では登録できない' do
      @stores_tag.price = "foobar"
      @stores_tag.valid?
      expect(@stores_tag.errors.full_messages).to include("料金は数値で入力してください")
    end
    it 'priceが整数以外の数値では登録できない' do
      @stores_tag.price = "1.1"
      @stores_tag.valid?
      expect(@stores_tag.errors.full_messages).to include("料金は整数で入力してください")
    end
    it 'store_timeが空では登録できない' do
      @stores_tag.store_time = ""
      @stores_tag.valid?
      expect(@stores_tag.errors.full_messages).to include("営業時間を入力してください")
    end
    it 'linkがURLパターンでないと登録できない' do
      @stores_tag.link = "foobar"
      @stores_tag.valid?
      expect(@stores_tag.errors.full_messages).to include("URLは不正な値です")
    end
  end
end
