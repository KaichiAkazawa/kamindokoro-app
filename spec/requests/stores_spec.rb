require 'rails_helper'

RSpec.describe 'Stores', type: :request do
  before do
    @owner_user = FactoryBot.create(:owner_user)
    @store = Store.new(
      name: 'test',
      address: 'test',
      station: 'test',
      price: '1000',
      store_time: 'test',
      owner_user_id: @owner_user.id
    )
    @store.image = fixture_file_upload('public/images/test_sample.jpg')
    @store.save
  end

  describe 'GET #index' do
    it '正常にレスポンスが返ってくる' do
      get root_path
      expect(response.status).to eq 200
      expect(response).to render_template('stores/index')
    end
  end

  describe 'GET #new' do
    context 'オーナーユーザーでログインしている場合' do
      before do
        sign_in @owner_user
      end
      it '正常にレスポンスが返ってくる' do
        get new_store_path
        expect(response.status).to eq 200
        expect(response).to render_template('stores/new')
      end
    end
    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされる' do
        get new_store_path
        expect(response.status).to eq 302
        expect(response).to redirect_to new_owner_user_session_path
      end
    end
  end

  describe 'GET #show' do
    it '正常にレスポンスが返ってくる' do
      get store_path(@store)
      expect(response.status).to eq 200
      expect(response).to render_template('stores/show')
    end
  end
end
