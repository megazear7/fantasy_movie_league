class AddApiidToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :apiid, :integer, null: false
  end
end
