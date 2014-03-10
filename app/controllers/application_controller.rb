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
end
