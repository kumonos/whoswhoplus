class FriendsController < ApplicationController

	# 検索ページ
	def show
		# render text: "fb_idは#{params[:fb_id]}"
		@profile = Profile.getUser(params[:fb_id])

		# dbに格納
		Profile.insert(@profile.api.get_object("/#{@profile.fb_id}/friends", 'fields'=>'name,gender,picture,relationship_status'), params[:fb_id])

    # 取得
    # TODO 上と処理を併合したい
    @friends = Profile.where({friend_mutual: params[:fb_id]}.merge(search_params))
		render 'friends' #viewのhamlの名前
	end

  private
    def search_params
      { gender: params[:gender] }
    end
end
