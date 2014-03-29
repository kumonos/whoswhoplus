class FriendsController < ApplicationController

	# 検索ページ
	def show
		#ユーザーの友人のfb_idよりトークンを取得
		@profile=Profile.getUser(params[:fb_id])
		
		#ユーザーの友人の友人情報をprofilesに格納
		friends_friends=@profile.api.get_object('/me/friends','fields'=>'name,gender,picture,relationship_status')
		Profile.insert(friends_friends)
		#「ユーザーの友人」と「友人の友人」のfb_idをrelationsに登録する
		Relation.insert(parames[:user_fb_id]params[:fb_id],friends_friends)

		render 'friends' #viewのhamlの名前
	end

	# 検索結果ページ
	def search
		@friends=Profile.search(params[:gender])

		render 'friends' #viewのhamlの名前
	end



end
