class InvitesController < ApplicationController
  before_action :requires_login
  # GET /invites/new
  def new
  	@invite_friends=Profile.checkFriendsWithNoToken(@current_user.fb_id)
  end

  # 
  def send_invitation

    fb_id = params[:via]	
    @current_user.chat_api.try { |c| c.send(fb_id, message_to_invite) }

    respond_to do |format|
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