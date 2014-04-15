class SearchForm
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :gender
  attr_accessor :relationship_status

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