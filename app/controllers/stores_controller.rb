class StoresController < ApplicationController
  def index
    @stores = Store.all
  end

  def new
    @store = Store.new
  end

  def create
    @store = Store.new(store_params)
    binding.pry
    if @store.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def store_params
    params.require(:store).permit(:name, :image, :adress, :station, :price, :store_time, :link).merge(owner_user_id: current_owner_user.id)
  end
end
