class RelationsController < ApplicationController
  before_action :requires_login
  before_action :set_relations_and_profile

  # GET /relations/:user
  # 紹介画面：指定ユーザへの経路を提案する
  def index
    # 経由できる人を検索する
    @vias = Profile.where(fb_id: @relations.pluck(:friend_mutual))

    # 経路が見つかればrender
    if @profile.present? && @vias.any?
      render
    else
      flash[:warning] = '指定された経路でユーザがみつかりませんでした'
      redirect_to root_path
    end
  end

  # GET /relations/:user/via/:via
  # メッセージ送信画面：経由する人にメッセージを送信する
  def show
    # 経由してきた人を検索する
    @via = Profile.where(fb_id: params[:via]).first
    @templates = Template.all

    # 経路が見つかればrender
    if @relations.one? && @via.present?
      render
    else
      flash[:warning] = '指定された経路でユーザがみつかりませんでした'
      redirect_to root_path
    end
  end

  private
    # 紹介してもらう相手と、紹介できる友人のリストを作る
    def set_relations_and_profile
      p = { profile_id: @current_user.id, friend_friend: params[:user] }
      p.merge!(friend_mutual: params[:via]) if params[:via].present?
      @relations = Relation.where(p)
      @profile   = Profile.where(fb_id: params[:user]).first
    end
end
