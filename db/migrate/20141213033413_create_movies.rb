class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :name, null: false
      t.integer :box_office_actual, default: 0, null: false
      t.date :release, null: false

      t.timestamps
    end
  end
end
