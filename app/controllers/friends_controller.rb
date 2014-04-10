class FriendsController < ApplicationController

	# 検索ページ
	def show
		#ユーザーの友人のfb_idよりトークンを取得
		@profile=Profile.getUser(params[:fb_id])
		
		#ユーザーの友人の友人情報をprofilesに格納
		@friends_friends=@profile.api.get_object('/me/friends','fields'=>'name,gender,picture,relationship_status')
		Profile.insert(@friends_friends)
		#「ユーザーの友人」と「友人の友人」のfb_idをrelationsに登録する
		Relation.insert(params[:fb_id],@friends_friends)

		@q = Profile.search(params[:gender])
		@profile = Profile.getUser(params[:fb_id])
		@result = @q.result

		render 'friends' #viewのhamlの名前
	end

	
	# 検索結果ページ
	#def search
	#	@q = Profile.search(params[:q])
	#	@profile = Profile.getUser(params[:fb_id])
	#	@result = @q.result(distinct: true)

	#	render 'show'
	#end

  private
    def search_params
      { gender: params[:gender] }
    end
end
