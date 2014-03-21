class HomeController < ApplicationController
  # GET /
  # ログイン状態に応じて画面を切り替える
  def index
    if @current_user
      # ログイン状態
      @friends = @current_user.api.get_object('/me/friends')
      @friends_pic=@current_user.api.get_object('/me/friends','fields'=>'gender,birthday,picture')    
      @friends_pic.each do |key|

        #puts key["picture"]["data"]["url"].to_s
         
      end  
      
    else
      # 非ログイン状態
      session[:oauth] = Koala::Facebook::OAuth.new(APP_ID, APP_SECRET, SITE_URL + ':3000/home/callback')
      @auth_url = session[:oauth].url_for_oauth_code(permissions: "read_stream")

      render 'intro'
    end
  end

  # ログイン状態を作り、ホームにリダイレクトさせる
  # GET /home/callback
	def callback
    #begin
      token = AccessToken.create!(access_token: session[:oauth].get_access_token(params[:code]))
      api = Koala::Facebook::API.new(token.access_token)
      profile = Profile.insert_or_update(api.get_object('/me'), token)
      session[:current_user] = profile.id
    #rescue
      # TODO
    #else
      redirect_to root_path
    #end


  end

end

