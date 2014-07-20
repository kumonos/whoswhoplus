class InvitesController < ApplicationController
  before_action :requires_login
  # GET /invites/new
  def new
  	@invite_friends=Profile.checkFriendsWithNoToken(@current_user.fb_id)
  end

  # 
  def send_invitation

    begin
      @current_user.chat_api.try { |c| c.send(@via.fb_id, message_to_invite) }
    byebug
    rescue ActiveRecord::RecordInvalid => e
      flash.now[:danger] = 'エラーが発生しました'
      render :new
    end

    respond_to do |format|
      format.html {render :new}
      format.js
    end
  end

  private
    def message_to_invite
      " #{@current_user.name} さんがあなたをフレンズポップに招待しています！
フレンズポップは、「カワイイ女子」「イケてる男子」を探してつながれる Web サービスです。
}#{SITE_URL}/"
    end

end