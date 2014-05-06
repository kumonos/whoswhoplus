require 'spec_helper'

describe MessagesController do
  shared_examples 'when not signed in' do
    it '302 Found' do
      expect(response.status).to eq 302
    end

    it 'redirects to root_path' do
      expect(response).to redirect_to root_path
    end
  end

  shared_examples 'assigns all templates' do
    it do
      expect(assigns(:templates).count).to eq 1
      expect(assigns(:templates).first.body).to eq '$$NAME$$さんを紹介してください'
    end
  end

  before do
    @from    = create(:profile)
    @to      = create(:profile)
    @target  = create(:profile)
    Relation.store!(@from.fb_id, @to.fb_id)
    Relation.store!(@to.fb_id, @target.fb_id)
    @message = create(:message, fb_id_from: @from.fb_id, fb_id_to: @to.fb_id, fb_id_target: @target.fb_id, message: 'HELLO')
    @dummy   = create(:message, fb_id_from: @to.fb_id, fb_id_to: @target.fb_id, fb_id_target: @from.fb_id)
    @template = create(:template, body: '$$NAME$$さんを紹介してください')
  end

  describe 'GET index' do
    context 'サインインしていない場合' do
      before do
        get :index
      end

      it_behaves_like 'when not signed in'
    end

    context 'サインインしている場合' do
      before do
        fake_signed_in @from
        get :index
      end

      it '200 OK' do
        expect(response.status).to eq 200
      end

      it 'サインインしているユーザが送信した Messages を assigns する' do
        expect(assigns(:messages).count).to eq 1
        expect(assigns(:messages).first.message).to eq 'HELLO'
      end
    end
  end

  describe 'GET new' do
    before do
      fake_signed_in @from
      get :new, user: @target.fb_id, via: @to.fb_id
    end

    it '200 OK' do
      expect(response.status).to eq 200
    end

    it_behaves_like 'assigns all templates'

    it 'assigns empty Message' do
      expect(assigns(:message).message).to be_nil
    end
  end

  describe 'POST create' do
    context 'メッセージがない場合' do
      before do
        fake_signed_in @from
        post :create, message: { message: '' }, user: @target.fb_id, via: @to.fb_id
      end

      it '200 OK' do
        expect(response.status).to eq 200
      end
    end

    context 'メッセージがある場合' do
      before do
        fake_signed_in @from
        post :create, message: { message: 'HELLO' }, user: @target.fb_id, via: @to.fb_id
        FacebookChat::Client.any_instance.stub(:send).and_return(true)
      end

      it '200 OK' do
        expect(response.status).to eq(200)
      end

      it 'assigns sent Message' do
        message = assigns(:message)
        expect(message.fb_id_from).to   eq @from.fb_id
        expect(message.fb_id_to).to     eq @to.fb_id
        expect(message.fb_id_target).to eq @target.fb_id
        expect(message.message).to      eq 'HELLO'
      end

      it_behaves_like 'assigns all templates'
    end
  end
end
