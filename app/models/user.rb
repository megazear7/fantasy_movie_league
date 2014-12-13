class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :rosters
  has_and_belongs_to_many :friends,
          class_name: "User",
          join_table: :friendships,
          foreign_key: :user_id,
          association_foreign_key: :friend_user_id

  def open_friend_requests
    FriendRequest.where(requestee_id: self.id)
  end

  def open_season_requests
    SeasonRequest.where(requestee_id: self.id)
  end

end
