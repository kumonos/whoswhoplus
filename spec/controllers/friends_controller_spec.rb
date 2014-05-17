require 'spec_helper'

describe FriendsController do
  describe 'GET #show' do
  	it '最小年齢が0以下の場合は[年齢は0以上にしてください]' do
  	    expect(SearchForm.new(age_min: -1,age_max: 10)).to have(1).errors_on(:age_min)
  	end
  	it '最小年齢が最大年齢より大きい[最小年齢は最大年齢以上にしてください]' do
  		expect(SearchForm.new(age_min: 10,age_max: 5)).not_to be_valid
  	end
  end
end
