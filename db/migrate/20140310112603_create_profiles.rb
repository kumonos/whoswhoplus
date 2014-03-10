class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :access_token
      t.string :fb_id, null: false
      t.string :name, null: false
      t.date :birthday
      t.string :gender
      t.string :relationship_status
      t.string :picture_url

      t.timestamps

      t.index :access_token_id, unique: true
      t.index :fb_id, unique: true
    end
  end
end
