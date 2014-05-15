require 'spec_helper'

describe FriendsController do
  describe 'GET #show' do
  	it '最小年齢が0以下の場合は[年齢は0以上にしてください]'
  	it '最大年齢が0以下[年齢は0以上にしてください]'
  	it '最小年齢が最大年齢より大きい[最小年齢は最大年齢以上にしてください]'
  end
end
