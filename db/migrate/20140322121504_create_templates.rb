class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.string :objective
      t.text :body

      t.timestamps
    end
  end
end
