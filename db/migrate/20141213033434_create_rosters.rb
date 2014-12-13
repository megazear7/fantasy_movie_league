class CreateRosters < ActiveRecord::Migration
  def change
    create_table :rosters do |t|

      t.integer :user_id, null: false
      t.integer :season_id, null: false

      t.integer :movie_one_id
      t.integer :movie_two_id
      t.integer :movie_three_id
      t.integer :movie_four_id
      t.integer :movie_five_id
      t.integer :movie_six_id
      t.integer :movie_seven_id
      t.integer :movie_eight_id
      t.integer :movie_nine_id
      t.integer :movie_ten_id

      t.integer :darkhorse_one_id
      t.integer :darkhorse_two_id
      t.integer :darkhorse_three_id

      t.timestamps
    end
  end
end
