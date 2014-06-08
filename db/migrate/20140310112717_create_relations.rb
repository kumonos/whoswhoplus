class CreateRelations < ActiveRecord::Migration
  def up
    create_table :relations do |t|
      t.string :fb_id_from, null: false
      t.string :fb_id_to, null: false

      t.timestamps

      t.index [:fb_id_from, :fb_id_to], unique: true
    end
  end

  def down
    drop_table :relations
  end
end
