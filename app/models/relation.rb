class Relation < ActiveRecord::Base
  belongs_to :profile

  # -----------------------------------------------------------------
  # Public Class Methods
  # -----------------------------------------------------------------
  # ユーザーの友人、友人の友人のリレーションを登録する
  # @param ユーザーの友人のfb_id
  # @param [Hash] 友人の友人の情報(ユーザの友人のトークンで取得した/me/friendsの返り値)
  # @return 
  def self.insert(fb_id,friends_friends)
  	friends_friends.each do |friend|
  		if fb_id.to_i>friend['id'].to_i then
  			id_older=fb_id
  			id_younger=friend['id']
  		else
  			id_older=friend['id']
  			id_younger=fb_id
  		end
      relation= Relation.where(:fb_id_younger =>id_younger,:fb_id_older => id_older).first
      if relation.new_record?
  		  Relation.create!(
  			  fb_id_younger:id_younger,
  			  fb_id_older:id_older
  			  )
      else
        puts "not new record "
  	  end
  end

end
