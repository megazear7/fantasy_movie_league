class AddSeasonOwnerAndFlags < ActiveRecord::Migration
  def change
    add_column :seasons, :user_id, :integer
    add_column :seasons, :finalized, :boolean, default: false
    add_column :rosters, :finalized, :boolean, default: false
  end
end
