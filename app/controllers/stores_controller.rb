class StoresController < ApplicationController
  def index
    @tags = Tag.all
    @stores = Store.all.order(created_at: :desc).page(params[:page]).per(6)
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

  # タグ検索
  def tag_search
    @tags = Tag.all
    @tag = Tag.find(params[:tag_id])
    @stores = @tag.stores.all.page(params[:page]).per(6)
  end
  
  # キーワード検索
  def keyword_search
    @tags = Tag.all
    @stores = Store.keyword_search(params[:keyword]).order(created_at: :desc).page(params[:page]).per(6)
    @keyword = params[:keyword]
  end

  private

  def store_params
    params.require(:store).permit(:name, :image, :address, :station, :price, :store_time,
                                       :link, :word).merge(owner_user_id: current_owner_user.id)
  end
end
