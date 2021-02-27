class CustomerUsersController < ApplicationController
  def show
    customer_user = CustomerUser.find(params[:id])
    @name = customer_user.name
  end
end
