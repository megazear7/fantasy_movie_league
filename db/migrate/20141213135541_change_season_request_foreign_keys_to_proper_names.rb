class ChangeSeasonRequestForeignKeysToProperNames < ActiveRecord::Migration
  def change
    rename_column :season_requests, :requester, :requester_id
    rename_column :season_requests, :requestee, :requestee_id
  end
end
