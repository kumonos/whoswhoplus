class SearchForm
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :gender
  attr_accessor :relationship_status

  def initialize(params)
    self.gender = params[:gender] if params
    self.relationship_status = params[:relationship_status] if params
  end

  def persisted?
    false
  end
end