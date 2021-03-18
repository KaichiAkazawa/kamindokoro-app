class StoresController < ApplicationController
  def index
    @stores = Store.all.order(created_at: :desc)
  end

  def new
    @store_tag = StoresTag.new
  end

  def create
    @store_tag = StoresTag.new(store_params)
    tag_list = params[:store][:word].split(',')
    if @store_tag.valid?
      @store_tag.save(tag_list)
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
    @store_tag = StoresTag.new(store: @store)
  end

  def update
    @store = Store.find(params[:id])
    redirect_to root_path unless owner_user_signed_in? && current_owner_user == @store.owner_user
    @store_tag = StoresTag.new(store_params, store: @store)
    tag_list = params[:store][:word].split(',')
    if @store_tag.valid?
      @store_tag.save(tag_list)
      redirect_to store_path(@store)
    else
      render :edit
    end
  end

  def destroy
    @store = Store.find(params[:id])
    redirect_to root_path unless owner_user_signed_in? && current_owner_user == @store.owner_user
    @store.destroy
    redirect_to root_path
  end

  # 店舗投稿時に設定する既存タグを検索
  def tag_search
    return nil if params[:keyword] == ''

    tag = Tag.where(['word LIKE ?', "%#{params[:keyword]}%"])
    render json: { keyword: tag }
  end

  # 店舗を検索
  def store_search
    @stores = Store.store_search(params[:keyword]).order(created_at: :desc)
  end

  private

  def store_params
    params.require(:store).permit(:name, :image, :address, :station, :price, :store_time,
                                       :link, :word).merge(owner_user_id: current_owner_user.id)
  end
end
