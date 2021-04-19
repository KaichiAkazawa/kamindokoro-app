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

  describe 'オーナーユーザー新規登録できない' do
    it 'nameが空では登録できない' do
      @owner_user.name = ''
      @owner_user.valid?
      expect(@owner_user.errors.full_messages).to include('名前を入力してください')
    end
    it 'emailが空では登録できない' do
      @owner_user.email = ''
      @owner_user.valid?
      expect(@owner_user.errors.full_messages).to include('Eメールを入力してください')
    end
    it 'emailに@がないと登録できない' do
      @owner_user.email = 'foobar'
      @owner_user.valid?
      expect(@owner_user.errors.full_messages).to include('Eメールは不正な値です')
    end
    it 'emailが重複すると登録できない' do
      @owner_user.save
      another_user = FactoryBot.build(:owner_user, email: @owner_user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
    end
    it 'passwordが空では登録できない' do
      @owner_user.password = ''
      @owner_user.valid?
      expect(@owner_user.errors.full_messages).to include('パスワードを入力してください')
    end
    it 'passwordが6文字以上でないと登録できない' do
      @owner_user.password = 'a' * 5
      @owner_user.valid?
      expect(@owner_user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
    end
    it 'passwordとpassword_confirmationが一致していないと登録できない' do
      @owner_user.password_confirmation = ''
      @owner_user.valid?
      expect(@owner_user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
    end
  end
end
