class BookmarksController < ApplicationController
  before_action :authenticate_customer_user!

  def create
    @store = Store.find(params[:store_id])
    @bookmark = Bookmark.create(customer_user_id: current_customer_user.id, store_id: @store.id)
    redirect_to store_path(@store)
  end

  def destroy
    @store = Store.find(params[:store_id])
    @bookmark = Bookmark.find_by(customer_user_id: current_customer_user.id, store_id: @store.id)
    @bookmark.destroy
    redirect_to store_path(@store)
  end
end
