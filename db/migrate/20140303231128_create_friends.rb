class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.string :from_facebook_id
      t.string :to_facebook_id

      t.timestamps
    end
  end
end
