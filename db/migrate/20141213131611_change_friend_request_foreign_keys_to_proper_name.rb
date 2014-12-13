class ChangeFriendRequestForeignKeysToProperName < ActiveRecord::Migration
  def change
    rename_column :friend_requests, :requester, :requester_id
    rename_column :friend_requests, :requestee, :requestee_id
  end
end
