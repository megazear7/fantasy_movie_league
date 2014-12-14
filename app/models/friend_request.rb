class FriendRequest < ActiveRecord::Base
  belongs_to :requester, class_name: "User"
  belongs_to :requestee, class_name: "User"

  def self.relevant_users_for user
    (User.all.to_a - user.friends.to_a) - [user]
  end
end
