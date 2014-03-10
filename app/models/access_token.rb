class AccessToken < ActiveRecord::Base
  has_one :profile
end
