class AddFinalScoreToRostersAndHasEndedFlagToSeasons < ActiveRecord::Migration
  def change
    add_column :rosters, :final_score, :integer, default: 0
    add_column :seasons, :has_ended, :boolean, default: false
  end
end
