class Relation < ActiveRecord::Base
  belongs_to :profile

  validates :fb_id_younger, :uniqueness => {:scope => :fb_id_younger}

  # -----------------------------------------------------------------
  # Public Class Methods
  # -----------------------------------------------------------------
  # ユーザーの友人、友人の友人のリレーションを登録する
  # @param ユーザーの友人のfb_id
  # @param [Hash] 友人の友人の情報(ユーザの友人のトークンで取得した/me/friendsの返り値)
  # @return 
  def self.insert(fb_id,friends_friends)
  	friends_friends.each do |friend|
      begin
        store(fb_id,friend[id])
      rescue
        next
      end
    end
  end

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
  def store(*fb_ids)
    fb_ids.sort_by! { |id| id.to_i }
    Relation.create!(fb_id_younger: fb_ids[0], fb_id_older: fb_ids[1])
  end

end
