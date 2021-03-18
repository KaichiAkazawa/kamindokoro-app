require 'rails_helper'

RSpec.describe OwnerUser, type: :model do
  before do
    @owner_user = FactoryBot.build(:owner_user)
  end

  describe 'オーナーユーザー新規登録できる' do
    it '必要な情報を入力すれば新規登録できる' do
      expect(@owner_user).to be_valid
    end
  end

  describe 'カスタマーユーザー新規登録できない' do
    it 'nameが空では登録できない' do
      @owner_user.name = ""
      @owner_user.valid?
      expect(@owner_user.errors.full_messages).to include("Name can't be blank")
    end
    it 'emailが空では登録できない' do
      @owner_user.email = ""
      @owner_user.valid?
      expect(@owner_user.errors.full_messages).to include("Email can't be blank")
    end
    it 'emailに@がないと登録できない' do
      @owner_user.email = "foobar"
      @owner_user.valid?
      expect(@owner_user.errors.full_messages).to include("Email is invalid")
    end
    it 'passwordが空では登録できない' do
      @owner_user.password = ""
      @owner_user.valid?
      expect(@owner_user.errors.full_messages).to include("Password can't be blank")
    end
    it 'passwordが6文字以上でないと登録できない' do
      @owner_user.password = "a" * 5
      @owner_user.valid?
      expect(@owner_user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
    it 'passwordとpassword_confirmationが一致していないと登録できない' do
      @owner_user.password_confirmation = ""
      @owner_user.valid?
      expect(@owner_user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
  end
end
