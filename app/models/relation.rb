class Relation < ActiveRecord::Base
  belongs_to :profile
  

  # -----------------------------------------------------------------
  # Validations
  # -----------------------------------------------------------------
  validates :fb_id_older, uniqueness: { scope: :fb_id_younger }

  # -----------------------------------------------------------------
  # Public Class Methods
  # -----------------------------------------------------------------
  # ユーザー、友人のリレーションを登録する
  # @param ユーザーのfb_id
  # @param [Hash] 友人の情報(ユーザのトークンで取得した/me/friendsの返り値)
  # @return 
  def self.insert(fb_id,friends)
  	friends.each do |friend|
      begin
        self.store!(fb_id,friend['id'])
      rescue ActiveRecord::RecordInvalid => e
        # 重複によるバリデーションエラーは無視
        next
      end
    end
  end

  # 指定した2人のユーザ間の共通の友人を取得する
  # @param [String] fb_id_1 ユーザ1
  # @param [String] fb_id_2 ユーザ2
  # @return [[Profile]] 共通の友人の Profile の配列
  def self.common_friends(fb_id_1, fb_id_2)
    # TODO 人数が大きくなってきたらもうちょっと改善の余地あるかも……。
    friends1 = RelationsView.where(fb_id_from: fb_id_1).pluck(:fb_id_to)
    friends2 = RelationsView.where(fb_id_from: fb_id_2).pluck(:fb_id_to)
    Profile.where(fb_id: friends1 & friends2)
  end

  # 友人関係を登録する（順序は問わない）
  # @param [String] fb_id_1 ユーザ1
  # @param [String] fb_id_2 ユーザ2
  def self.store!(*fb_ids)
    fb_ids.sort_by! { |id| id.to_i }
    param = { fb_id_younger: fb_ids[0], fb_id_older: fb_ids[1] }
    Relation.create!(param) if Relation.where(param).count == 0
  end
end
