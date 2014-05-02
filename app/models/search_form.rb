class SearchForm
  include ActiveModel::Model

  attr_accessor :gender,:relationship_status,:age_min,:age_max,:no_age
  validates :age_min, :age_max, :presence => true
  validates :age_min, :numericality => {:greater_than_or_equal_to =>0}  # {:less_than_or_equal_to => :age_max}にするとArgumentError - comparison of Float with String failedでエラー発生
  validates :age_max, :numericality => {:greater_than_or_equal_to =>0}


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