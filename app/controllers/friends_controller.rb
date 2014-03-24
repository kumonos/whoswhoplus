class FriendsController < ApplicationController

	# 検索ページ
	def show
		#render text: "fb_idは#{params[:fb_id]}"
		@profile=Profile.getUser(params[:fb_id])
		#dbに格納
		
		
		Profile.insert(@profile.api.get_object('/me/friends','fields'=>'name,gender,picture,relationship_status'),params[:fb_id])
		@friends=Array.new
		render 'friends' #viewのhamlの名前
	end

	def search
		@friends=Profile.search(params[:gender])

		render 'friends' #viewのhamlの名前
	end


	# 検索結果ページ
end
