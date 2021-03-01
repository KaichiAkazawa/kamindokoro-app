class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to store_path(@comment.store)
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(customer_user_id: current_customer_user.id, store_id: params[:store_id])
  end
end
