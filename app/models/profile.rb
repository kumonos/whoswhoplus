class Profile < ActiveRecord::Base
  # -----------------------------------------------------------------
  # Relations
  # -----------------------------------------------------------------
  belongs_to :access_token
  has_many :relations

  # -----------------------------------------------------------------
  # Public Class Methods
  # -----------------------------------------------------------------
  # Facebook APIの返り値からユーザ情報を作成する
  # すでにいる場合はそれを返す
  # @param [Hash] /me の返り値
  # @param [AccessToken]
  # @return [Profile] ユーザ情報
  def self.insert_or_update(me, token)
    # すでに存在していないか探す
    profile = Profile.where(fb_id: me['id']).first

    # 存在していない場合新しく作る
    if profile.nil?
      profile = Profile.create!(
        access_token_id: token.id,
        fb_id: me['id'],
        name: me['name'],
        birthday: nil, # TODO
        gender: me['gender'],
        relationship_status: me['relationship_status'],
        picture_url: me['picture'].try { |p| p['data'].try { |d| d['url'] } }
      )
    end

    profile
  end

  # -----------------------------------------------------------------
  # Public Class Methods
  # -----------------------------------------------------------------
  # ユーザの Friendsのトークンがあるかどうかを確認する
  # Friendsのトークン情報を配列でまとめて返す
  # @param [Hash] /me/friendの返り値
  # 
  def self.checkFriendsToken(me_friends)

      profile = Profile.where(fb_id:me_friends.first['id'])
  
  end  

  # -----------------------------------------------------------------
  # Public Instance Methods
  # -----------------------------------------------------------------
  # Facebook Graph APIをインスタンス化する
  def api
    Koala::Facebook::API.new(self.access_token.access_token)
  end

  # 年齢を取得する
  # @return [Integer] 年齢
  def age
    birth = self.birthday.strftime('%Y%m%d').to_i
    today = Date.today.strftime('%Y%m%d').to_i
    return (birth - today) / 10000
  end
end
