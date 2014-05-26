require 'spec_helper'

shared_examples_for 'Not Found' do
  it '404を返す' do
    expect(response.status).to eq 404
  end

  it 'flashに見つからなかったことを記録する' do
    expect(flash[:warning]).to be_present
  end
end

describe RelationsController do
  # テストデータ作成
  before do
    # AccessToken 作成
    token = create(:access_token)

    # Profile作成
    @p1 = create(:profile, access_token_id: token.id)
    @p2 = create(:profile)
    @p3 = create(:profile)
    @p4 = create(:profile)
    @p5 = create(:profile)
    @p6 = create(:profile)

    # 適当に友達関係を結ぶ
    # 1が認証ユーザ
    # 1と2, 1と3が友達
    # 2と4, 2と5が友達
    # 3と4が友達
    # 6は誰とも友達ではない
    Relation.store!(@p1.fb_id, @p2.fb_id)
    Relation.store!(@p1.fb_id, @p3.fb_id)
    Relation.store!(@p2.fb_id, @p4.fb_id)
    Relation.store!(@p2.fb_id, @p5.fb_id)
    Relation.store!(@p3.fb_id, @p4.fb_id)

    # テンプレート投入
    3.times { create(:template) }

    # ログイン中として振る舞う
    session[:current_user] = @p1.id
  end

  describe 'GET #index' do
    context '指定ユーザへの経路がある場合' do
      before do
        Koala::Facebook::API.any_instance.stub(:get_object).and_return([ { 'id' => @p2.fb_id }, { 'id' => @p3.fb_id } ])

        get :index, user: @p4.fb_id
      end

      it '200を返す' do
        expect(response.status).to eq 200
      end

      it '指定ユーザをviewに渡す' do
        expect(assigns[:profile]).to eq @p1
      end

      it '経路をviewに渡す' do
        expect(assigns[:vias]).to match_array [@p2, @p3]
      end

      it 'relations/indexをrenderする' do
        expect(response).to render_template 'relations/index'
      end
    end

    context '指定ユーザがいない場合' do
      before do
        Koala::Facebook::API.any_instance.stub(:get_object).and_return([])

        get :index, user: 'not_found'
      end
      it_behaves_like 'Not Found'
    end

    context '指定ユーザと共通の友人がいない場合' do
      before do
        Koala::Facebook::API.any_instance.stub(:get_object).and_return([])

        get :index, user: @p6.fb_id
      end
      it_behaves_like 'Not Found'
    end
  end
end
