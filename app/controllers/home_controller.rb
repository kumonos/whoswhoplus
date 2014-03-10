class HomeController < ApplicationController
  # GET /
  # ログイン状態に応じて画面を切り替える
  def index
    if @current_user
      # ログイン状態
      @friends = @current_user.api.get_object('/me/friends')
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

		#begin
		#	@graph_data = @api.get_object("/me/statuses", "fields"=>"message")
		#	@pic_data=@api.get_object("100003980373324","fields"=>"picture")
		#	#userのプロフィール画像とれる
		#	puts @api.get_object("100003980373324","fields"=>"picture")
    #
		#	#message一覧
		#	puts @api.get_object("/me/statuses","fields"=>"message")
		#rescue Exception=>ex
		#	puts ex.message
		#end
		#puts @pic_data.class
		#puts @pic_data['picture']['data']['url']
		##parse がうまくいかない
		##hash=JSON.parse @pic_data
		##parsed=hash['picture']
  end
end

