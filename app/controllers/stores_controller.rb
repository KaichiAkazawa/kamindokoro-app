class StoresController < ApplicationController
  def index
    @stores = Store.all
  end

  def new
    @store = Store.new
  end

  def create
    @store = Store.new(store_params)
    if @store.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @store = Store.find(params[:id])
  end

  def edit
    @store = Store.find(params[:id])
    unless owner_user_signed_in? && current_owner_user == @store.owner_user
      redirect_to root_path
    end
  end

  def update
    @store = Store.find(params[:id])
    unless owner_user_signed_in? && current_owner_user == @store.owner_user
      redirect_to root_path
    end
    @store.update(store_params)
  end

  def destroy
    @store = Store.find(params[:id])
    unless owner_user_signed_in? && current_owner_user == @store.owner_user
      redirect_to root_path
    end
    @store.destroy
    redirect_to root_path
  end

  private
  def store_params
    params.require(:store).permit(:name, :image, :adress, :station, :price, :store_time, :link).merge(owner_user_id: current_owner_user.id)
  end
end
