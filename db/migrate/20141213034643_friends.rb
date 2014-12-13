class Friends < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :user_id
      t.integer :friend_user_id
    end

    create_table :friend_requests do |t|
      t.integer :requester, null: false
      t.integer :requestee, null: false
      t.text :message, default: "Hello, would you like to share stats?"
      t.boolean :active, default: true
    end

    create_table :season_requests do |t|
      t.integer :season_id
      t.integer :requester, null: false
      t.integer :requestee, null: false
      t.text :message, default: "Hello, would you like to compete in my league?"
      t.boolean :active, default: true
    end

  end
end
