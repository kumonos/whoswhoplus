class FriendsController < ApplicationController
@@check_flg = "false"
	   
	# 検索ページ
	def show
		#ユーザーの友人のfb_idよりトークンを取得
		@profile=Profile.getUser(params[:fb_id])

        if @@check_flg == "false"
		#ユーザーの友人の友人情報をprofilesに格納
		@friends_friends=@profile.api.get_object('/me/friends','fields'=>'name,gender,picture,relationship_status')
		Profile.insert(@friends_friends)
		#「ユーザーの友人」と「友人の友人」のfb_idをrelationsに登録する
		Relation.insert(params[:fb_id],@friends_friends)
		@@check_flg = "true"
	    end
		@search_form =  SearchForm.new params[:search_form]
	    @results=Profile.search(:gender => @search_form.gender,:relationship_status =>@search_form.relationship_status)

		render 'friends' #viewのhamlの名前
	end

	
	# 検索結果ページ
	def search_result


	
	end

  private
    def search_params
      { gender: params[:gender] }
    end
end
