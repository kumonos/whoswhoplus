class FriendsController < ApplicationController
	   
	# 検索ページ
	def show
		@profile=Profile.getUser(params[:fb_id])
		@search_form =  SearchForm.new params[:search_form]
		
	     
	   if @search_form.no_age.present?
	   #TODO 年齢データなしとありを同時に表示できるようにする
	   @results=Profile.search(:gender => @search_form.gender,
	   :relationship_status =>@search_form.relationship_status,
	   :fb_id=>params[:fb_id],
	   :no_age=>@search_form.no_age)
	   else
	   	if @search_form.age_max.nil?
	   		@search_form.age_max=40
	   	end
	   	if @search_form.age_min.nil?
	   		@search_form.age_min=0
	   	end
	   @results=Profile.search(:gender => @search_form.gender,
	   :relationship_status =>@search_form.relationship_status,
	   :fb_id=>params[:fb_id],
	   :age_max=>@search_form.age_max,
	   :age_min=>@search_form.age_min)

	   end

	   if @search_form.invalid?
		  @error_message=@search_form.errors.messages
	   end  
	   render 'friends' #viewのhamlの名前
	end


  private
    def search_params
      { gender: params[:gender] }
    end
end
