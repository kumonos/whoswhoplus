require 'spec_helper'

describe Friend do
  describe '#age' do
    it '誕生日前日には年齢は上がらない'
    it '誕生日当日に年齢が上がる'
  end
end
