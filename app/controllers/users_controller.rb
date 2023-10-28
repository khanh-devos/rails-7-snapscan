class UsersController < ApplicationController
  def splash; end

  def user_sign_out
    sign_out(current_user)
    redirect_to '/'
  end
end
