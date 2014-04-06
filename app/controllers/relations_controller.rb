class RelationsController < ApplicationController
  before_action :requires_login
  before_action :set_relations_and_profile

  # GET /relations/:user
  # 紹介画面：指定ユーザへの経路を提案する
  def index
    # 経由できる人を検索する
    @vias = Profile.where(fb_id: @relations)

    # 経路が見つかればrender
    if @profile.present? && @vias.any?
      render
    else
      flash[:warning] = '指定された経路でユーザがみつかりませんでした'
      render 'home/404'
    end
  end

  # GET /relations/:user/via/:via
  # メッセージ送信画面：経由する人にメッセージを送信する
  def show
    # テンプレート読み込み
    @templates = Template.all

    # 経路が見つかればrender
    if @relations.include?(params[:via])
      @via = Profile.find_by_fb_id(params[:via])
      render
    else
      flash[:warning] = '指定された経路でユーザがみつかりませんでした'
      render 'home/404'
    end
  end

  private
    # 紹介してもらう相手と、紹介できる友人のリストを作る
    def set_relations_and_profile
      @profile   = Profile.find_by_fb_id(params[:user])
      @relations = Relation.common_friends(@current_user.fb_id, params[:user])
    end
end
