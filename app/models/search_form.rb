class SearchForm
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :gender
  attr_accessor :relationship_status
  attr_accessor :age_min
  attr_accessor :age_max

  validates :age_check

  def age_check
    errors.add(attr, '最小年齢を記入してください') if :age_min == nil and :age_max != nil
    errors.add(attr, '最大年齢を記入してください') if :age_min != nil and :age_max == nil
    errors.add(attr, '最大値と最小値が正しくありません') if :age_min > :age_max 
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