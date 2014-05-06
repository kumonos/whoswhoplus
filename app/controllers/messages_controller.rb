class MessagesController < ApplicationController
  before_action :requires_login
  before_action :check_common_friends, only: [:new, :create]

  # GET /messages
  def index
    # 送信済みメッセージ取得
    @messages = Message.includes(:recipient_profile).where(fb_id_from: @current_user.fb_id)
  end

  # GET /messages/new
  def new
    # テンプレート読み込み
    @templates = Template.all
    @message = Message.new
  end

  # POST /messages
  def create
    @templates = Template.all
    @message = Message.new(message_params)

    begin
      client = @current_user.chat_api

      unless client.nil?
        client.send(@via.fb_id, @message.message_to_send)
        @message.save!
      end
    # ActiveRecord::RecordInvalid 以外の想定外エラーとして扱うべきなのでここで rescue しない
    rescue ActiveRecord::RecordInvalid => e
      flash.now[:danger] = @message.errors.full_messages.first.presence || 'エラーが発生しました'
      render :new
    end
  end

  private
    def message_params
      params.require(:message).permit(:message).merge(fb_id_from: @current_user.fb_id, fb_id_to: @via.fb_id, fb_id_target: @profile.fb_id)
    end
end
