class BookmarksController < ApplicationController
  before_action :authenticate_customer_user!
  before_action :set_store

  def create
    Bookmark.create(customer_user_id: current_customer_user.id, store_id: @store.id)
  end

  def destroy
    bookmark = Bookmark.find_by(customer_user_id: current_customer_user.id, store_id: @store.id)
    bookmark.destroy
  end

  private

  def set_store
    @store = Store.find(params[:store_id])
  end
end
