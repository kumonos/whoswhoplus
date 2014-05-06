class HomeController < ApplicationController
  # GET /
  # ログイン状態に応じて画面を切り替える
  def index


    if @current_user
      # ログイン状態
      @friends = Profile.checkFriendsToken(@current_user.api.get_object('/me/friends','fields'=>'name,gender,picture.width(200).height(200)'))
    else
      render 'intro'
    end
  end

  # ログイン状態を作り、ホームにリダイレクトさせる
  # GET /home/callback
	def callback
    begin
      token = request.env['omniauth.auth'][:credentials][:token]
      access_token = AccessToken.create!(access_token: token)
    rescue => e
      Rails.logger.warn "認証失敗 #{e.class.to_s}: #{e.message}"
      flash[:danger] = '認証に失敗しました！'
    end

    api = Koala::Facebook::API.new(token)
    profile = Profile.insert_or_update(api.get_object('/me','fields'=>'name,gender,picture.width(200).height(200)'), access_token)
    session[:current_user] = profile.id

    redirect_to root_path
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

