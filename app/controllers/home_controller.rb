class HomeController < ApplicationController
  # GET /
  # ログイン状態に応じて画面を切り替える
  def index
    if @current_user
      # ログイン状態
      @friends = Profile.checkFriendsToken(@current_user.api.get_object('/me/friends','fields'=>'name,gender,picture'))
 
    
      
    else
      # 非ログイン状態
      session[:oauth] = Koala::Facebook::OAuth.new(APP_ID, APP_SECRET, SITE_URL + ':3000/home/callback')
      #permission 必要なものだけ
      #public_profile
      #relationship_status
      #friends_birthday
      #friends_relationship
      @auth_url = session[:oauth].url_for_oauth_code(:permissions=>'public_profile,friends_birthday,friends_relationships')
      
      render 'intro'
    end
  end

  # ログイン状態を作り、ホームにリダイレクトさせる
  # GET /home/callback
	def callback
    #begin
      token = AccessToken.create!(access_token: session[:oauth].get_access_token(params[:code]))
      api = Koala::Facebook::API.new(token.access_token)
      profile = Profile.insert_or_update(api.get_object('/me','fields'=>'name,gender,picture'), token)
      session[:current_user] = profile.id
    #rescue
      # TODO
    #else
      redirect_to root_path
    #end


  end

  # get /sign_out
  def sign_out
    session[:current_user] = nil
    flash[:info] = 'ログアウトしました！'
    redirect_to root_path
  end

  # GET /dummy_login
  # 危険なので開発環境でしか呼べないようにすること！
  def dummy_form
    render
  end

  # POST /dummy_login
  # 危険なので開発環境でしか呼べないようにすること！
  def dummy_login
    session[:current_user] = params[:user_id]
    flash[:info] = 'なりすましログインしました'
    redirect_to root_path
  end
end

