class AddFbIdTargetToMessages < ActiveRecord::Migration
  def up
    add_column    :messages, :fb_id_target, :string
    change_column :messages, :fb_id_from,   :string, null: false
    change_column :messages, :fb_id_to,     :string, null: false
  end

  def down
    remove_column :messages, :fb_id_target
    change_column :messages, :fb_id_from,   :string
    change_column :messages, :fb_id_to,     :string
  end
end
