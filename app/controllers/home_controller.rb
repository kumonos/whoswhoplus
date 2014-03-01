require 'json'
class HomeController < ActionController::Base
  protect_from_forgery

   def index
   	session[:oauth] = Koala::Facebook::OAuth.new(APP_ID, APP_SECRET, SITE_URL + ':3000/home/callback')
		@auth_url =  session[:oauth].url_for_oauth_code(:permissions=>"read_stream")

		puts session.to_s + "<<< session"

  	respond_to do |format|
			 format.html {  }
		 end
  end

	def callback
  	if params[:code]
  		# acknowledge code and get access token from FB
		  session[:access_token] = session[:oauth].get_access_token(params[:code])
		end

		 # auth established, now do a graph call:

		@api = Koala::Facebook::API.new(session[:access_token])
		begin
			@graph_data = @api.get_object("/me/statuses", "fields"=>"message")
			@pic_data=@api.get_object("100003980373324","fields"=>"picture")
			#@pic_data=@api.get_object("/me/photos")
			puts @api.get_object("100003980373324","fields"=>"picture")
			#puts  @api.get_object("/me/photos")
			#puts @api.get_connections("me","friends")
			puts @api.get_object("/me/statuses","fields"=>"message")
		rescue Exception=>ex
			puts ex.message
		end
		puts @pic_data.class
		puts @pic_data['picture']['data']['url']

		#hash=JSON.parse @pic_data
		#parsed=hash['picture']

		#puts @data=@pic_data['picture']
		#puts @url_data=@data['data']
		#puts @url=@url_data['url']
		#@url_data.each do |pic|
		#	puts pic['url']
		#end

 		respond_to do |format|
		 format.html {   }
		end


	end
end

