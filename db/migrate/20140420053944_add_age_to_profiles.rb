class AddAgeToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :age, :integer
  end
end
