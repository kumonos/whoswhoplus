# Viewなのでsaveとかしちゃだめ
# このViewはrelationsを作るmigrationと同時に作られる
class RelationsView < ActiveRecord::Base
  self.table_name = :relations_view
end
