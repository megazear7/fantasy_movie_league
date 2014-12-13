class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.date :begin_date, default: Date.today, null: false
      t.date :end_date, default: Date.today >> 6, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
