class FriendRequest < ActiveRecord::Base
  belongs_to :requester, class_name: "User"
  belongs_to :requestee, class_name: "User"
  validate :cannot_make_friends_with_self
  validate :cannot_make_friends_twice
  validate :cannot_send_two_friend_requests

  def cannot_make_friends_with_self
    if requestee == requester
      errors.add(:requestee_id, "You cannot be friends with yourself")
    end
  end

  def cannot_make_friends_twice
    if requester.friends.to_a.include? requestee
      errors.add(:requestee_id, "You are already friends with them")
    end
  end

  def cannot_send_two_friend_requests
    if FriendRequest.exists?(requestee: requestee, requester: requester)
      errors.add(:requestee_id, "You already sent them a friend request")
    end
  end

  def self.relevant_users_for user
    (User.all.to_a - user.friends.to_a) - [user]
  end
end
