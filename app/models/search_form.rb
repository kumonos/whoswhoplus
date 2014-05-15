class SearchForm
  include ActiveModel::Model

  attr_accessor :gender,:relationship_status,:age_min,:age_max,:no_age
  validates :age_min, :numericality => {:greater_than_or_equal_to =>0,:message=>'年齢は0以上にしてください'}
  # {:less_than_or_equal_to => :age_max}にするとArgumentError - comparison of Float with String failedでエラー発生
  validates :age_max, :numericality => {:greater_than_or_equal_to =>0,:message=>'年齢は0以上にしてください'}
  validate :age_check

  def age_check
    errors.add(:age_min ,'最小年齢は最大年齢以下にしてください') if age_min > age_max
  end


  def initialize(params)
    if params
     params.each do |key, value|
       setter_method = "#{key.to_s}=".to_sym
       self.__send__(setter_method, value) if self.respond_to?(setter_method)
     end
    end
  end

  def persisted?
    false
  end
end