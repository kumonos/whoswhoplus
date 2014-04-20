class FriendsController < ApplicationController
	   
	# 検索ページ
	def show
		#ユーザーの友人のfb_idよりトークンを取得
		@profile=Profile.getUser(params[:fb_id])
		#ログインしてから1時間以上経過していた場合またはcreated_atとupdated_atが同じ場合はデータを更新する
        if @profile.updated_at  <= 1.hour.ago || @profile.created_at = @profile.updated_at
		#ユーザーの友人の友人情報をprofilesに格納
		@friends_friends=@profile.api.get_object('/me/friends','fields'=>'name,gender,picture,relationship_status,birthday')
		Profile.insert(@friends_friends)
		#「ユーザーの友人」と「友人の友人」のfb_idをrelationsに登録する
		Relation.insert(params[:fb_id],@friends_friends)
		@profile.touch
	    end
		@search_form =  SearchForm.new params[:search_form]

		if @search_form.valid?
   
		   if @search_form.no_age.present?
		   #TODO:データなしの場合はage_min,age_maxが入っていても優先される
		   @results=Profile.search(:gender => @search_form.gender,
	       :relationship_status =>@search_form.relationship_status,
	       :fb_id=>params[:fb_id],
	       :no_age=>params[:no_age])
   
		   else
	       @results=Profile.search(:gender => @search_form.gender,
	       :relationship_status =>@search_form.relationship_status,
	       :fb_id=>params[:fb_id],
	       :age_max=>params[:age_max],
	       :age_min=>params[:age_min])
	       end
	    end

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
