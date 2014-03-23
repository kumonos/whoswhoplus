class RelationsController < ApplicationController
  #before_action :requires_login
  before_action def stub
    @current_user = Profile.find(12)
  end

  # GET /relations/:user
  # 紹介画面：指定ユーザへの経路を提案する
  def index
    # 指定ユーザまでの経路を検索する
    relations = Relation
      .where(profile_id: @current_user.id, friend_friend: params[:user])
      .pluck(:friend_mutual)

    # 経路の有無によって分岐
    if relations.any?
      # TODO 見つからなかったときのことを一切考えてない
      @profile = Profile.where(fb_id: params[:user]).first
      @vias = Profile.where(fb_id: relations)
    else
      # TODO 404にでもする
    end
  end

  # GET /relations/:user/via/:via
  # メッセージ送信画面：経由する人にメッセージを送信する
  def show
    # Validation
    relations = Relation
      .where(profile_id: @current_user.id, friend_friend: params[:user], friend_mutual: params[:via])

    if relations.one?
      # TODO 見つからなかったときのことを一切考えてない
      # TODO 上記と処理を共通化できないか検討必要
      @profile = Profile.where(fb_id: params[:user]).first
      @via = Profile.where(fb_id: params[:via]).first
      @templates = Template.all
    else
      # TODO 該当の経路なし。404にする
    end
  end
end
