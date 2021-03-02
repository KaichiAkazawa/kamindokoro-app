class CustomerUsersController < ApplicationController
  def show
    customer_user = CustomerUser.find(params[:id])
    @name = customer_user.name
    @bookmarks = customer_user.bookmarks
  end
end
