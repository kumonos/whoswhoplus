require 'spec_helper'

describe Profile do
  describe 'Public Class Methods' do
    describe '#find_by_fb_id' do
      pending
    end
  end

  describe 'Public Instance Methods' do
    describe '#api' do
      it 'アクセストークンがあれば Koala::Facebook::API を返す'
      it 'アクセストークンがなければ nil を返す'
    end

    describe '#chat_api' do
      it 'アクセストークンがあれば FacebookChat::Client を返す'
      it 'アクセストークンがなければ nil を返す'
    end

    describe '#age' do
      it '生年月日から年齢を返す'
    end
  end
end
