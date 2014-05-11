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
      Rails.logger.info access_token.inspect

      api = Koala::Facebook::API.new(token)
      profile = Profile.insert_or_update(api.get_object('/me','fields'=>'name,gender,picture.width(200).height(200)'), access_token)
      Rails.logger.info profile.inspect
      
      update_friends_data(profile.fb_id)

      session[:current_user] = profile.id
      flash[:success] = 'サインインしました！'
    rescue => e
      flash[:danger] = '認証に失敗しました！'
      raise e # 内部サーバーエラーに渡す
    end

    redirect_to root_path
  end

  # get /sign_out
  def sign_out
    session[:current_user] = nil
    flash[:info] = 'ログアウトしました！'
    redirect_to root_path
  end

  #ユーザーの友人情報を取得または更新する
  # @param fb_id
  def update_friends_data(fb_id)
    @profile=Profile.getUser(fb_id)
    #更新時間が1分以内(ログイン直後)または1時間以上経過している場合データを更新する
          
    if @profile.updated_at  >= 1.minute.ago ||  @profile.updated_at <= 1.hour.ago
      #ユーザーの友人情報をprofilesに格納
      @friends=@profile.api.get_object('/me/friends','fields'=>'name,gender,picture.width(200).height(200),relationship_status,birthday')
      Profile.insert(@friends)
      #「ユーザーの友人」と「友人」のfb_idをrelationsに登録する
      Relation.insert(fb_id,@friends)
      @profile.touch
    end
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

