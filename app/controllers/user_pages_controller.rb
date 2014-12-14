class UserPagesController < ApplicationController

  def home
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = User.find(current_user.id)
    end
  end

end
