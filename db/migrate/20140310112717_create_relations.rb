class CreateRelations < ActiveRecord::Migration
  def change
    create_table :relations do |t|
      t.string :friend_friend, null: false
      t.string :friend_mutual, null: false
      t.references :profile, null: false

      t.timestamps

      t.index [:friend_friend, :friend_mutual], unique: true
    end
  end
end
