require 'spec_helper'

describe ApplicationHelper do
  describe '#rails_env' do
    it '"[TEST] "を返す' do
      expect(rails_env).to eq '[TEST] '
    end
  end

  describe '#breadcrumbs' do
    it 'ラベルとリンクの組み合わせをリンクに変換する' do
      expect(breadcrumbs([%w(HOME /)])).to eq '<ol class="breadcrumb"><li><a href="/">HOME</a></li></ol>'
    end

    it 'ラベルのみの場合はリンクにしない' do
      expect(breadcrumbs(%w(CURRENT))).to eq '<ol class="breadcrumb"><li class="active">CURRENT</li></ol>'
    end
  end

  describe '#lf2br' do
    it '改行を <br> に変換する' do
      expect(lf2br("HELLO\nWORLD")).to eq 'HELLO<br>WORLD'
    end
  end
end
