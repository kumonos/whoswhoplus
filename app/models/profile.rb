class Profile < ActiveRecord::Base
  # 年齢を取得する
  # @return [Integer] 年齢
  def age
    birth = self.birthday.strftime('%Y%m%d').to_i
    today = Date.today.strftime('%Y%m%d').to_i
    return (birth - today) / 10000
  end
end
