require 'rails_helper'

RSpec.describe CustomerUser, type: :model do
  before do
    @customer_user = FactoryBot.build(:customer_user)
  end

  describe 'カスタマーユーザー新規登録できる' do
    it '必要な情報を入力すれば新規登録できる' do
      expect(@customer_user).to be_valid
    end
  end

  describe 'カスタマーユーザー新規登録できない' do
    it 'nameが空では登録できない' do
      @customer_user.name = ""
      @customer_user.valid?
      expect(@customer_user.errors.full_messages).to include("Name can't be blank")
    end
    it 'emailが空では登録できない' do
      @customer_user.email = ""
      @customer_user.valid?
      expect(@customer_user.errors.full_messages).to include("Email can't be blank")
    end
    it 'emailに@がないと登録できない' do
      @customer_user.email = "foobar"
      @customer_user.valid?
      expect(@customer_user.errors.full_messages).to include("Email is invalid")
    end
    it 'passwordが空では登録できない' do
      @customer_user.password = ""
      @customer_user.valid?
      expect(@customer_user.errors.full_messages).to include("Password can't be blank")
    end
    it 'passwordが6文字以上でないと登録できない' do
      @customer_user.password = "a" * 5
      @customer_user.valid?
      expect(@customer_user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
    it 'passwordとpassword_confirmationが一致していないと登録できない' do
      @customer_user.password_confirmation = ""
      @customer_user.valid?
      expect(@customer_user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
  end
end
