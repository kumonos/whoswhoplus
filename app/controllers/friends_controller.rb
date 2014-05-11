class FriendsController < ApplicationController
	   
	# 検索ページ
	def show
		@profile=Profile.getUser(params[:fb_id])
		@search_form =  SearchForm.new params[:search_form]

		if @search_form.valid?
   
		   if @search_form.no_age.present?
		   #TODO:データなしの場合はage_min,age_maxが入っていても優先される
		   @results=Profile.search(:gender => @search_form.gender,
	       :relationship_status =>@search_form.relationship_status,
	       :fb_id=>params[:fb_id],
	       :no_age=>@search_form.no_age)

   
		   else
	       @results=Profile.search(:gender => @search_form.gender,
	       :relationship_status =>@search_form.relationship_status,
	       :fb_id=>params[:fb_id],
	       :age_max=>@search_form.age_max,
	       :age_min=>@search_form.age_min)
	       end
	    end

		render 'friends' #viewのhamlの名前
	end


  private
    def search_params
      { gender: params[:gender] }
    end
end
