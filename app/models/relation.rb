class Relation < ActiveRecord::Base
  # -----------------------------------------------------------------
  # Public Class Methods
  # -----------------------------------------------------------------
  # 指定した2人のユーザ間の共通の友人を取得する
  # @param [String] fb_id_1 ユーザ1
  # @param [String] fb_id_2 ユーザ2
  def self.common_friends(fb_id_1, fb_id_2)
    # TODO 人数が大きくなってきたらもうちょっと改善の余地あるかも……。
    friends1 = RelationsView.where(fb_id_from: fb_id_1).pluck(:fb_id_to)
    friends2 = RelationsView.where(fb_id_from: fb_id_2).pluck(:fb_id_to)
    friends1 & friends2
  end

  # 友人関係を登録する（順序は問わない）
  # @param [String] fb_id_1 ユーザ1
  # @param [String] fb_id_2 ユーザ2
  def self.store(*fb_ids)
    fb_ids.sort_by! { |id| id.to_i }
    Relation.create!(fb_id_younger: fb_ids[0], fb_id_older: fb_ids[1])
  end
end
