class CreateRelations < ActiveRecord::Migration
  def up
    create_table :relations do |t|
      t.string :fb_id_younger, null: false
      t.string :fb_id_older, null: false

      t.timestamps

      t.index [:fb_id_younger, :fb_id_older], unique: true
    end

    execute <<-SQL
      CREATE VIEW relations_view AS
        SELECT
          fb_id_younger AS fb_id_from,
          fb_id_older   AS fb_id_to
        FROM relations
      UNION ALL
        SELECT
          fb_id_older   AS fb_id_from,
          fb_id_younger AS fb_id_to
        FROM relations;
    SQL
  end

  def down
    drop_table :relations
  end
end
