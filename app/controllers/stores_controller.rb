class StoresController < ApplicationController
  def index
    @stores = Store.all
  end

  def new
    @store = StoresTag.new
  end

  def create
    @store = StoresTag.new(store_params)
    if @store.valid?
      @store.save
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
    redirect_to root_path unless owner_user_signed_in? && current_owner_user == @store.owner_user
  end

  def update
    @store = Store.find(params[:id])
    redirect_to root_path unless owner_user_signed_in? && current_owner_user == @store.owner_user
    @store.update(store_params)
  end

  def destroy
    @store = Store.find(params[:id])
    redirect_to root_path unless owner_user_signed_in? && current_owner_user == @store.owner_user
    @store.destroy
    redirect_to root_path
  end

  def search
    return nil if params[:keyword] == ""
    tag = Tag.where(['word LIKE ?', "%#{params[:keyword]}%"])
    render json:{ keyword: tag }
  end

  private

  def store_params
    params.require(:stores_tag).permit(:name, :image, :adress, :station, :price, :store_time,
                                  :link, :word).merge(owner_user_id: current_owner_user.id)
  end
end
