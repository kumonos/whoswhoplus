class InvitesController < ApplicationController
  before_action :requires_login
  # GET /invites/new
  def new
  	@invite_friends=Profile.checkFriendsWithNoToken(@current_user.fb_id)
    @invite_mutual_friends=@current_user.checkFriendsMutual
    @message = Message.new  
  end

  def send_invitation
    @via = Profile.find_by_fb_id(params[:via])
    @message = Message.new(message_params)
    fb_id = params[:via]
    begin
      @message.save!
      @current_user.chat_api.try { |c| c.send(@via.fb_id, message_to_invite) }
    rescue ActiveRecord::RecordInvalid => e
        flash.now[:danger] = @message.errors.full_messages.first.presence || 'エラーが発生しました'        
    end
    flash[:success] = 'success!'
    #画面遷移????
  end

  private
    def message_to_invite
      " #{@current_user.name} さんがあなたをフレンズポップに招待しています！
--
#{@message.message}
--
フレンズポップは、「カワイイ女子」「イケてる男子」を探してつながれる Web サービスです。
#{SITE_URL}/"
    end

    def message_params
      params.require(:message).permit(:message).merge(fb_id_from: @current_user.fb_id, fb_id_to: @via.fb_id, fb_id_target: @via.fb_id)
    end

end