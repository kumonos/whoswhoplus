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
      @bob   = create(:profile, name: 'Bob',   access_token_id: 1)
      @mike  = create(:profile, name: 'Mike',  access_token_id: 2)
      @mary  = create(:profile, name: 'Mary',  access_token_id: nil)
      @nancy = create(:profile, name: 'Nancy', access_token_id: nil)
    end

    context '紹介を依頼する相手が Who\'s who ++ ユーザの場合' do
      it '送られた理由を説明し、サービス紹介は省略する' do
        message = Message.new(message: 'test', fb_id_from: @bob.fb_id, fb_id_to: @mike.fb_id, fb_id_target: @mary.fb_id)
        expect(message.message_to_send).to eq "test

--
このメッセージは Bob さんがあなたの友人の Mary ( #{@mary.facebook_url} ) さんに興味を持ち、フレンズポップ経由で送信したメッセージです。
http://localhost:3000/"
      end
    end

    context '紹介を依頼する相手が Who\'s who ++ ユーザではない場合' do
      it '送られた理由とサービス紹介を返す' do
        message = Message.new(message: 'test', fb_id_from: @bob.fb_id, fb_id_to: @mary.fb_id, fb_id_target: @nancy.fb_id)
        expect(message.message_to_send).to eq "test

--
このメッセージは Bob さんがあなたの友人の Nancy ( #{@nancy.facebook_url} ) さんに興味を持ち、フレンズポップ経由で送信したメッセージです。
Who's who ++ は、「友人の友人」を探してつながれる Web サービスです。
http://localhost:3000/"
      end
    end
  end
end
