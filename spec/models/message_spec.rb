require 'spec_helper'

describe Message do
  describe 'Validations' do
    it 'is valid' do
      expect(build(:message)).to be_valid
    end

    it 'message がなければ invalid' do
      expect(build(:message, message: '')).to have(1).error_on(:message)
    end

    it 'fb_id_from がなければ invalid' do
      expect(build(:message, fb_id_from: '')).to have(1).error_on(:fb_id_from)
    end

    it 'fb_id_to がなければ invalid' do
      expect(build(:message, fb_id_to: '')).to have(1).error_on(:fb_id_to)
    end

    it 'fb_id_target がなければ invalid' do
      expect(build(:message, fb_id_target: '')).to have(1).error_on(:fb_id_target)
    end
  end

  describe '#message_to_send' do
    before do
      @from   = create(:profile, name: 'ふろむ')
      @to     = create(:profile, name: 'とぅー')
      @target = create(:profile, name: 'たげと')
    end

    it 'サービスから一言を追加して返す' do
      message = Message.new(message: 'test', fb_id_from: @from.fb_id, fb_id_to: @to.fb_id, fb_id_target: @target.fb_id)
      expect(message.message_to_send).to include 'このメッセージは ふろむ さんがあなたの友人の たげと さんに興味を持ち、 Who\'s Who ++ 経由で送信したメッセージです。'
    end
  end
end
