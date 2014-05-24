class ApplicationController < ActionController::Base
  protect_from_forgery

  # すべての画面でログインチェックを実施する
  before_action :check_login

  # エラーを捕捉
  if Rails.env.staging? || Rails.env.production?
    rescue_from ActiveRecord::RecordNotFound, ActionController::RoutingError, with: :render_404
    rescue_from Exception, with: :render_500
  end

  def find_current_user
    Profile.find(session[:current_user])
  end

  def check_login
    if session[:current_user].present?
      @current_user = find_current_user
    else
      @current_user = nil
    end
  end

  # ログイン必須とする場合に呼ぶ
  def requires_login
    if @current_user.nil?
      flash[:warning] = 'ログインしてください！'
      redirect_to root_path
    end
  end

  # 指定したユーザと共通の友人を検索する
  def check_common_friends
    # この人を紹介してほしい
    @profile = Profile.find_by_fb_id(params[:user])

    # その人を紹介できる人を API に問い合わせて探す
    # TODO そのうちキャッシュを考える
    via_candidates = @current_user.api
      .get_object("/v2.0/#{params[:user]}?fields=context.fields(mutual_friends)")['context']['mutual_friends']['data']
      .map{ |h| h['id']}

    @vias = Profile.where(fb_id: via_candidates)

    # その中でこの人に紹介してほしい
    @via = @vias.where(fb_id: params[:via]).first if params[:via].present?

    # 紹介してほしい相手がいない場合、紹介できる友人がいない場合、その中に経由したい人がいない場合はエラー
    if @profile.nil? || @vias.empty? || (params[:via].present? && @via.nil?)
      flash.now[:warning] = '指定された経路でユーザがみつかりませんでした'
      render 'home/404', status: :not_found
    end
  end

  # 404 で応答する
  def render_404(exception = nil)
    render 'home/404', status: :not_found, formats: :html
  end

  # 500 で応答する
  # @param [Exception] exception 補足したエラー
  def render_500(exception = nil)
    @inquiry_key = Random.rand(10000000 .. 99999999).to_s

    Rails.logger.fatal("Rendering 500... inquiry_key: #{@inquiry_key}")
    Rails.logger.fatal(exception.class)
    Rails.logger.fatal(exception.message)
    Rails.logger.fatal(exception.backtrace.join("\n"))

    begin
      SystemMailer.internal_server_error(request, exception, @inquiry_key).deliver
    rescue => e
      Rails.logger.fatal("Sending email has also failed: #{e.class} #{e.message}")
    end

    render 'home/500', status: :internal_server_error, formats: :html
  end
end
