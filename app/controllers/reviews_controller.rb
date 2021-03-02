class ReviewsController < ApplicationController
  before_action :authenticate_customer_user!, only: [:create]

  def index
    @review = Review.new
    @store = Store.find(params[:store_id])
    @reviews = @store.reviews
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to store_reviews_path(@review.store)
    else
      @store = Store.find(params[:id])
      render "store/show"
    end
  end

  private
  def review_params
    params.require(:review).permit(:score, :text).merge(customer_user_id: current_customer_user.id, store_id: params[:store_id])
  end
end
