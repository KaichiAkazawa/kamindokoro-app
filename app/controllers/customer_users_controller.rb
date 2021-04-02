class CustomerUsersController < ApplicationController
  def show
    @customer_user = CustomerUser.find(params[:id])
    @bookmarks = @customer_user.bookmarks
  end
end
