# Facebook Graph API から返された photo へのインターフェースを提供
# DB 非依存のため ActiveRecord::Base を継承しないモデルクラス
class Facebook::Photo
  # ------------------------------------------------------------------
  # Constructor
  # ------------------------------------------------------------------
  def initialize(hash)
    @underlying = hash
  end

  # ------------------------------------------------------------------
  # Public Instance Methods
  # ------------------------------------------------------------------
  # サムネイル画像のURLを返す
  # @return [String]
  def thumbnail_url
    @underlying['picture']
  end

  # 画像のURLを返す
  # @return [String]
  def photo_url
    @underlying['source']
  end

  # タグ付けされている位置を特定する
  # @param [String] fb_id Facebook ID
  # @return [Array] x, y 座標。見つからなかった場合 Array ではなく nil
  def find(fb_id)
    tag = @underlying['tags']['data'].select { |t| t['id'] == fb_id }.first
    tag.present? ? [tag['x'], tag['y']] : nil
  end

  # 指定したユーザが写真にタグ付けされているかどうかを返す
  # @param [String] fb_id Facebook ID
  # @return [bool] タグ付けされている場合 true
  def tagged?(fb_id)
    self.find(fb_id).present?
  end
end
