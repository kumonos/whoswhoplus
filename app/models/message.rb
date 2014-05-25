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
  validates :message, length: { minimum: 1, maximum: 4096 }
  validates :fb_id_from,   length: { minimum: 1, maximum: 256 }
  validates :fb_id_to,     length: { minimum: 1, maximum: 256 }
  validates :fb_id_target, length: { minimum: 1, maximum: 256 }

  # ------------------------------------------------------------------
  # Public Instance Methods
  # ------------------------------------------------------------------
  # Facebook のメッセージで送る本文を返す
  def message_to_send
    <<"__EOM__"
#{self.message}

--
このメッセージは #{self.sender_profile.name} さんがあなたの友人の #{self.target_profile.name} さんに興味を持ち、 Who's who ++ 経由で送信したメッセージです。
Who's who ++ は、「友人の友人」を探してつながれる Web サービスです。
#{SITE_URL}/
__EOM__
  end
end
