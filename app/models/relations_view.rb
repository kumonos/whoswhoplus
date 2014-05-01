# Viewなのでsaveとかしちゃだめ
# このViewはrelationsを作るmigrationと同時に作られる
class RelationsView < ActiveRecord::Base
	belongs_to :profile, foreign_key: :fb_id_from 
  self.table_name = :relations_view
end
