class RelationsController < ApplicationController
  before_action :requires_login
  before_action :check_common_friends

  # GET /relations/:user
  def index
    # 写真取得を試みる（失敗したら出さないだけ）
    # begin
    #   @photos = @vias
    #     .select(&:access_token_id)
    #     .sample
    #     .api
    #     .get_object("/#{@profile.fb_id}?fields=photos")['photos'].try do |p|
    #       p['data'].map { |q| Facebook::Photo.new(q) }
    #     end
    # rescue => e
    #   Rails.logger.warn e
    #   # NOOP
    # end
  end
end
