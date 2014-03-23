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
      raise
      redirect_to root_path
    end
  end
end
