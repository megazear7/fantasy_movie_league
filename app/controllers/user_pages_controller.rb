class UserPagesController < ApplicationController

  def home
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = User.find(current_user.id)
    end
  end

  def index
    @friend_request = FriendRequest.new
  end

  def leader_boards
  end

  def friends_leader_boards
  end
end
