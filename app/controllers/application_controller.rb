class ApplicationController < ActionController::Base
  protect_from_forgery

  # すべての画面でログインチェックを実施する
  before_action :check_login

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

    # その人を紹介できる人
    @vias    = Relation.common_friends(@current_user.fb_id, params[:user])

    # その中でこの人に紹介してほしい
    @via = @vias.where(fb_id: params[:via]).first if params[:via].present?

    # 紹介してほしい相手がいない場合、紹介できる友人がいない場合、その中に経由したい人がいない場合はエラー
    if @profile.nil? || @vias.empty? || (params[:via].present? && @via.nil?)
      flash.now[:warning] = '指定された経路でユーザがみつかりませんでした'
      render 'home/404', status: :not_found
    end
  end
end
