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
  # Facebook APIの返り値から友人の友人の情報をDBに格納する
  # @param [Hash] /me/friends の返り値
  # @param friend_mutual 共通の友人のID。検索の識別用
  # @return 
  # TODO 友人の友人の情報は別テーブルに格納したほうが良い気がするので検討する
  def self.insert(friends,friend_mutual)

    friends.each do |friend|
      #すでに存在していないか確認
      data=Profile.where(fb_id:friend['id'],friend_mutual:friend_mutual).first
      #TODO 途中で失敗してしまった場合の処理

      #存在していない場合は格納
      if data.nil? && (friend['id']==friend_mutual)
        data=Profile.create!(
          fb_id:friend['id'],
          name:friend['name'],
          birthday:nil,
          gender:friend['gender'],
          relationship_status:friend['relationship_status'],
          picture_url:friend['picture'].try { |p| p['data'].try { |d| d['url'] } },
          friend_mutual:friend_mutual
          )

      end

    end  

  end

  # -----------------------------------------------------------------
  # Public Class Methods
  # -----------------------------------------------------------------
  # formデータから検索
  # @param formの値
  # return [Hash] formの値
  # TODO 色々な検索条件に対応する

  def self.search(gender)
    data = Profile.where(gender: gender)
    return data
  end


  # -----------------------------------------------------------------
  # Public Class Methods
  # -----------------------------------------------------------------
  # ユーザの Friendsのトークンがあるかどうかを確認する
  # Friendsのトークン情報を返す
  # @param [Hash] /me/friendの返り値
  # 
  def self.checkFriendsToken(me_friends)

      profile = Profile.where(fb_id:me_friends.first['id'])
      return profile
  
  end

  # -----------------------------------------------------------------
  # Public Class Methods
  # -----------------------------------------------------------------
  # ユーザーの情報を取得する
  # 
  # @param fb_id
  # 
  def self.getUser(me_fb_id)

      profile = Profile.where(fb_id:me_fb_id).first
      return profile
  
  end

  # fb_id を指定してユーザ情報を取得する。取得できなかった場合 nil を返す
  # @param [String] fb_id
  # @return [Profile]
  def self.find_by_fb_id(fb_id)
    Profile.where(fb_id: fb_id).first
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
    return (today - birth) / 10000
  end
end
