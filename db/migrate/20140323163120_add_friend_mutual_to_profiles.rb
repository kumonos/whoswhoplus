class AddFriendMutualToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :friend_mutual, :string
  end
end
