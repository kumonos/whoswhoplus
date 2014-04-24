class Profile < ActiveRecord::Base
  # -----------------------------------------------------------------
  # Relations
  # -----------------------------------------------------------------
  belongs_to :access_token
  has_many :relations
  has_many :relations_views , foreign_key: :fb_id_from,primary_key: :fb_id

  # -----------------------------------------------------------------
  # Scopes
  # -----------------------------------------------------------------
  scope :has_token, -> { where.not(access_token_id: nil) }

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
  # Facebook APIの返り値からprofile情報をDBに格納する
  # @param [Hash] /me/friends の返り値
  # @return 
  def self.insert(friends)

    friends.each do |friend|
      #すでに存在していないか確認
      data=Profile.where(fb_id:friend['id']).first
      #TODO 途中で失敗してしまった場合の処理

      #存在していない場合は格納
      if data.nil? 
        data=Profile.create!(
          fb_id:friend['id'],
          name:friend['name'],
          birthday:friend['birthday'],
          age:Profile.age(friend['birthday']),
          gender:friend['gender'],
          relationship_status:friend['relationship_status'],
          picture_url:friend['picture'].try { |p| p['data'].try { |d| d['url'] } },
          )

      end

    end  

  end


  scope :by_gender, lambda {|gender| where("gender=?","#{gender}")}
  scope :by_relationship_status, lambda{|relationship_status| where("relationship_status=?","#{relationship_status}")}
  scope :by_relationship_status_null, ->{where("relationship_status IS NULL")}
  scope :by_age, lambda {|age_min,age_max| where(:conditions=>{:age => age_min...age_max})}
  scope :by_age_null, ->{where("age IS NULL")}
  # -----------------------------------------------------------------
  # Public Class Methods
  # -----------------------------------------------------------------
  # formデータから検索
  # @param formの値
  # return [Hash] formの値
  def self.search(params={})

    #exec_scopes=0

    return nil if params[:fb_id].nil?

    profile_result = Profile.where(fb_id: params[:fb_id])

    if params[:gender]
      profile_result = profile_result.by_gender(params[:gender])
    end

    if params[:relationship_status]
      if params[:relationship_status] == 'empty'
        profile_result = profile_result.by_relationship_status_null
      else
        profile_result = profile_result.by_relationship_status(params[:relationship_status])
      end
    end

    if params[:no_age].nil?
      if params[:age_min]
      profile_result = profile_result.by_age(params[:age_min],params[:age_max])
      end
    else
      profile_result = profile_result.by_age_null
    end

    return profile_result

  end



  # -----------------------------------------------------------------
  # Public Class Methods
  # -----------------------------------------------------------------
  # ユーザの Friendsのトークンがあるかどうかを確認する
  # Friendsのトークン情報を返す
  # @param [Hash] /me/friendの返り値
  # @return [[Profile]] トークンのある友人の Profile の配列
  def self.checkFriendsToken(me_friends)
    self.has_token.where(fb_id: me_friends.map{ |f| f['id'] })
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
  # Facebook Graph API をインスタンス化する
  # @return [Koala::Facebook::API]
  def api
    self.access_token.access_token.try { |t| Koala::Facebook::API.new(t) }
  end

  # FacebookChat::Client のインスタンスを返す
  # @return [FacebookChat::Client]
  def chat_api
    self.access_token.access_token.try { |t| FacebookChat::Client.new(t) }
  end

  # 年齢を取得する
  # param [String] birthday
  # @return [Integer] 年齢
  def self.age(birthday)
    formats = ['%m/%d/%Y','%m/%d']
    birth_f = nil
    if birthday
      formats.each do |format|
        begin
          birth_f =Date.strptime(birthday,format)
          break
        rescue ArgumentError
        end
      end
      if birth_f && birth_f.year
        birth = birth_f.strftime('%Y%m%d').to_i
        #birth = Date.parse(birthday).strftime('%Y%m%d').to_i
        today = Date.today.strftime('%Y%m%d').to_i
      return (today - birth) / 10000
      else
        return nil
      end
    end
  end
end
