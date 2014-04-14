class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :fb_id_from
      t.string :fb_id_to
      t.text :message

      t.timestamps
    end
  end
end
