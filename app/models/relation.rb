class Relation < ActiveRecord::Base
  belongs_to :fb_id_from, :class_name => 'Profile', foreign_key: :fb_id_from
  belongs_to :fb_id_to, :class_name => 'Profile' ,foreign_key: :fb_id_to

  # -----------------------------------------------------------------
  # Validations
  # -----------------------------------------------------------------
  validates :fb_id_from, uniqueness: { scope: :fb_id_to }

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
    # TODO ここの書き方正しい？というか、ここで定義すべきメソッドではない…？
    friends1 = Profile.where(fb_id: fb_id_1).friends_of_from_user.pluck(:fb_id)
    friends2 = Profile.where(fb_id: fb_id_2).friends_of_from_user.pluck(:fb_id)

    Profile.where(fb_id: friends1 & friends2)
  end

  # 友人関係を登録する（順序は考慮必要）
  # @param [String] fb_id_1 ユーザー
  # @param [String] fb_id_2 ユーザーの友人
  def self.store!(*fb_ids)
    fb_ids.sort_by! { |id| id.to_i }
    param = { fb_id_to: fb_ids[0], fb_id_from: fb_ids[1] }
    Relation.create!(param) if Relation.where(param).count == 0
  end
end
