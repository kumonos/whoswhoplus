require 'spec_helper'

describe InvitesController do
	shared_examples 'when not signed in' do
    it '302 Found' do
      expect(response.status).to eq 302
    end

    it 'redirects to root_path' do
      expect(response).to redirect_to root_path
    end
  end

  before do
  	token    = create(:access_token)
    @to      = create(:profile, name: 'Mary',  access_token_id: nil)
    @from    = create(:profile, name: 'Bob', access_token_id: token.id)
    @target  = create(:profile)
    Relation.store!(@from.fb_id, @to.fb_id)
    Relation.store!(@to.fb_id, @target.fb_id)
    Koala::Facebook::API.any_instance.stub(:get_object).and_return([ { 'id' => @to.fb_id } ])
  end

	describe 'GET new' do
		before do
		  fake_signed_in @from
      get :new
	  end

	  it '200 OK' do
      expect(response.status).to eq 200
    end

    it '招待できる友人がいる' do
    	expect(assigns(:invite_friends).first.fb_id).to eq @to.fb_id
    end
  end

  describe 'POST create' do
  	before do
  		fake_signed_in @from
      expect_any_instance_of(Profile).to receive_message_chain(:chat_api, :send).and_return(nil)
  	end

  	it '201 Created' do
      post :create, message: { message: Faker::Lorem.paragraph, fb_id_to: 1, fb_id_target: 1 }
      expect(response.status).to eq(201)
    end

    it 'Message が 1 件増える' do
      expect {
        post :create, message: { message: Faker::Lorem.paragraph, fb_id_to: 1, fb_id_target: 1 }
      }.to change(Message, :count).by 1
    end

    it '招待メッセージを送信' 
    	
    	#expect(InvitesController.send(:message_to_invite)).to eq " Bob さんがあなたをフレンズポップに招待しています！
#フレンズポップは、「カワイイ女子」「イケてる男子」を探してつながれる Web サービスです。
#http://localhost:3000/"
  end
end
