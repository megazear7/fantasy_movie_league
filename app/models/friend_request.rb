class FriendRequest < ActiveRecord::Base
  belongs_to :requester, class_name: "User"
  belongs_to :requestee, class_name: "User"
  validate :cannot_make_friends_with_self
  validate :cannot_make_friends_twice

  def cannot_make_friends_with_self
    if requestee == requester
      errors.add(:requestee_id, "You cannot be friends with yourself")
    end
  end

  def cannot_make_friends_twice
    if FriendRequest.exists?(requestee: requestee, requester: requester)
      errors.add(:requestee_id, "You cannot be friends with yourself")
    end
  end

  def self.relevant_users_for user
    (User.all.to_a - user.friends.to_a) - [user]
  end
end
