class ApplicationController < ActionController::Base
  protect_from_forgery

  # すべての画面でログインチェックを実施する
  before_action :check_login

  def check_login
    if session[:current_user].present?
      @current_user = Profile.find(session[:current_user])
    else
      @current_user = nil
    end
  end

  # ログイン必須とする場合に呼ぶ
  def requires_login
    if @current_user.nil?
      # TODO flashか何かで通知するほうがよい？
      redirect_to root_path
    end
  end
end
