class InvitesController < ApplicationController
  before_action :requires_login
  # GET /invites/new
  def new
  	@invite_friends=Profile.checkFriendsWithNoToken(@current_user.fb_id)
    @invite_mutual_friends=@current_user.checkFriendsMutual
    @message = Message.new  
  end

  # POST /invites
  def create
    @message = Message.new(message_params)

    # エラーになったらメール通知を飛ばすようにするため rescue しない
    @message.save!
    @current_user.chat_api.send(@message.fb_id_to, message_to_invite)

    render json: { result: 'OK' }, status: :created
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
      params
        .require(:message)
        .permit(:message, :fb_id_to, :fb_id_target)
        .merge(fb_id_from: @current_user.fb_id)
    end
end
