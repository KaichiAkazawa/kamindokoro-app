require 'rails_helper'

RSpec.describe CustomerUser, type: :model do
  before do
    @customer_user = FactoryBot.build(:customer_user)
  end

  describe 'カスタマーユーザー新規登録できる' do
    it '必要な情報を入力すれば新規登録できる' do
      expect(@customer_user).to be_valid
    end
    it 'プロフィール画像を設定しなくても登録できる' do
      @customer_user.avatar = nil
      expect(@customer_user).to be_valid
    end
  end

  describe 'カスタマーユーザー新規登録できない' do
    it 'nameが空では登録できない' do
      @customer_user.name = ''
      @customer_user.valid?
      expect(@customer_user.errors.full_messages).to include('名前を入力してください')
    end
    it 'emailが空では登録できない' do
      @customer_user.email = ''
      @customer_user.valid?
      expect(@customer_user.errors.full_messages).to include('Eメールを入力してください')
    end
    it 'emailに@がないと登録できない' do
      @customer_user.email = 'foobar'
      @customer_user.valid?
      expect(@customer_user.errors.full_messages).to include('Eメールは不正な値です')
    end
    it 'emailが重複すると登録できない' do
      @customer_user.save
      another_user = FactoryBot.build(:customer_user, email: @customer_user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
    end
    it 'passwordが空では登録できない' do
      @customer_user.password = ''
      @customer_user.valid?
      expect(@customer_user.errors.full_messages).to include('パスワードを入力してください')
    end
    it 'passwordが6文字以上でないと登録できない' do
      @customer_user.password = 'a' * 5
      @customer_user.valid?
      expect(@customer_user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
    end
    it 'passwordとpassword_confirmationが一致していないと登録できない' do
      @customer_user.password_confirmation = ''
      @customer_user.valid?
      expect(@customer_user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
    end
  end
end
