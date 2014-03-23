require 'spec_helper'

shared_examples_for 'Not Found' do
  it '302を返す' do
    expect(response.status).to eq 302
  end

  it 'flashに見つからなかったことを記録する' do
    expect(flash[:warning]).to be_present
  end
end

describe RelationsController do
  # テストデータ作成
  before do
    # Profile作成
    @p1 = create(:profile)
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
    create(:relation, friend_friend: @p4.fb_id, friend_mutual: @p2.fb_id, profile: @p1)
    create(:relation, friend_friend: @p5.fb_id, friend_mutual: @p2.fb_id, profile: @p1)
    create(:relation, friend_friend: @p4.fb_id, friend_mutual: @p3.fb_id, profile: @p1)

    # テンプレート投入
    3.times { create(:template) }

    # ログイン中として振る舞う
    session[:current_user] = @p1.id
  end

  describe 'GET #index' do
    context '指定ユーザへの経路がある場合' do
      before do
        get :index, user: @p4.fb_id
      end

      it '200を返す' do
        expect(response.status).to eq 200
      end

      it '指定ユーザをviewに渡す' do
        expect(assigns[:profile]).to eq @p4
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
        get :index, user: 'not_found'
      end
      it_behaves_like 'Not Found'
    end

    context '指定ユーザと共通の友人がいない場合' do
      before do
        get :index, user: @p6.fb_id
      end
      it_behaves_like 'Not Found'
    end
  end

  describe 'GET #show' do
    context '指定ユーザへの経路がある場合' do
      before do
        get :show, user: @p4.fb_id, via: @p2.fb_id
      end

      it '200を返す' do
        expect(response.status).to eq 200
      end

      it '指定ユーザをviewに渡す' do
        expect(assigns[:profile]).to eq @p4
      end

      it '経路をviewに渡す' do
        expect(assigns[:via]).to eq @p2
      end

      it 'テンプレートをviewに渡す' do
        expect(assigns[:templates]).to be_present
      end

      it 'relations/showをrenderする' do
        expect(response).to render_template 'relations/show'
      end
    end

    context '指定ユーザがいない場合' do
      before do
        get :show, user: 'not_found', via: @p2.fb_id
      end
      it_behaves_like 'Not Found'
    end

    context '経由ユーザが共通の友人ではない場合' do
      before do
        get :show, user: @p6.fb_id, via: @p2.fb_id
      end
      it_behaves_like 'Not Found'
    end
  end
end
