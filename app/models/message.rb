class Message < ActiveRecord::Base
  # ------------------------------------------------------------------
  # Relations
  # ------------------------------------------------------------------
  belongs_to :sender_profile, class_name: Profile, primary_key: :fb_id, foreign_key: :fb_id_from
  belongs_to :recipient_profile, class_name: Profile, primary_key: :fb_id, foreign_key: :fb_id_to

  # ------------------------------------------------------------------
  # Validations
  # ------------------------------------------------------------------
  validates :message, length: { minimum: 1, maximum: 4096 }
  validates :fb_id_from, length: { minimum: 1, maximum: 256 }
  validates :fb_id_to, length: { minimum: 1, maximum: 256 }
end
