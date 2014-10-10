class Message < ActiveRecord::Base
  # ------------------------------------------------------------------
  # Relations
  # ------------------------------------------------------------------
  belongs_to :sender_profile,    class_name: Profile, primary_key: :fb_id, foreign_key: :fb_id_from
  belongs_to :recipient_profile, class_name: Profile, primary_key: :fb_id, foreign_key: :fb_id_to
  belongs_to :target_profile,    class_name: Profile, primary_key: :fb_id, foreign_key: :fb_id_target

  # ------------------------------------------------------------------
  # Validations
  # ------------------------------------------------------------------
  validates :message, length: { maximum: 4096 }, presence: true
  validates :fb_id_from,   length: { minimum: 1, maximum: 256 }
  validates :fb_id_to,     length: { minimum: 1, maximum: 256 }
  validates :fb_id_target, length: { minimum: 1, maximum: 256 }

  # ------------------------------------------------------------------
  # Public Instance Methods
  # ------------------------------------------------------------------
  # Facebook のメッセージで送る本文を返す
  def message_to_send
    "#{self.message}

--
このメッセージは #{self.sender_profile.name} さんがあなたの友人の #{self.target_profile.name} ( #{self.target_profile.facebook_short_url} ) さんに興味を持ち、フレンズポップ経由で送信しました！
#{self.recipient_profile.access_token_id.present? ? '' : "フレンズポップは、「カワイイ女子」「イケてる男子」を探してつながれる Web サービスです。
"}#{SITE_URL}/"
  end
end
