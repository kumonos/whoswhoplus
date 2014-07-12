require 'spec_helper'

describe Profile do
  describe 'Public Class Methods' do
    describe '#insert_or_update' do
      before do
        #FacebookAPIから取得できるhashのデータ構造がprofilesと異なるので独自に作成しなくてはならない
        @regist_user1 = {
          "access_token"=>nil, 
          "id"=>"1533446810",
          "name"=>"田中 陸斗", 
          "gender"=>"男性",
          "relationship_status"=>"交際中"}
        @regist_user2 = {
          "access_token"=>nil, 
          "id"=>"8145796810",
          "name"=>"山田 花子", 
          "gender"=>"女性",
          "relationship_status"=>"既婚"}
        @regist_user3 = {
          "access_token"=>nil, 
          "id"=>"3147896810",
          "name"=>"佐藤 太郎", 
          "gender"=>"男性",
          "relationship_status"=>"配偶者と死別"}   
        @regist_user4 = {
          "access_token"=>nil, 
          "id"=>"9147896810",
          "name"=>"川田 琢磨", 
          "gender"=>"男性",
          "relationship_status"=>"既婚"}        
      end
      it '登録したユーザーの性別が男性の場合、maleを返す' do
        access_token = AccessToken.create!(access_token: '456')       
        profile = Profile.insert_or_update(@regist_user1,access_token)
        expect(profile.gender).to eq 'male'
      end
      it '登録したユーザーの関係性が既婚の場合、relationship_statusはMarriedを返す' do
        access_token = AccessToken.create!(access_token: '789')
        profile = Profile.insert_or_update(@regist_user2,access_token)
        expect(profile.relationship_status).to eq 'Married'
      end
      it '登録したユーザーの関係性が配偶者と死別の場合、relationship_statusはemptyを返す' do
        access_token = AccessToken.create!(access_token: '910')
        #regist_user = attributes_for(:regist_user, relationship_status: '配偶者と死別')
        profile = Profile.insert_or_update(@regist_user3,access_token)
        expect(profile.relationship_status).to eq 'empty'
      end
      it '登録したユーザーがすでにDBにいる(他のユーザーに登録されている)場合、token_idを更新する' do        
        access_token = AccessToken.create!(access_token: '123')
        create(:regist_user,fb_id: '9147896810')
        profile = Profile.insert_or_update(@regist_user4,access_token)
        expect(profile.access_token_id).to eq 1
      end
    end
    describe '#find_by_fb_id' do
      pending
    end
    describe '#age' do
      before do
        Date.stub(:today_test).and_return(Date.new(1994,1,25))
      end
      it 'birthdayが1/25/1994の場合、20を返す' do
        
        format = '%m/%d/%Y'
        expect(Profile.age(Date.today_test.strftime(format))).to eq 20
      end
      it 'birthdayが1/25の場合、年齢nilを返す' do
        expect(Profile.age('01/25')).to eq nil
      end
      it 'birthdayがnilの場合、年齢nilを返す' do
        expect(Profile.age(nil)).to eq nil
      end
    end

    describe '#all_friends' do
      before do
        create(:profile, fb_id: '10')
      end
      it 'fb_idがヒットしない場合nilが返る' do      
        expect(Profile.all_friends('30')).to eq nil
      end
      it '友人がいない場合は空が返る' do
        expect(Profile.all_friends('10')).to be_empty
      end
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

    describe '#name_with_link' do
      it { expect(build(:profile, fb_id: 'youcune', name: 'なかにしゆう').name_with_link).to eq '<a href="https://www.facebook.com/youcune" target="_blank">なかにしゆう</a>' }
    end

    describe '#facebook_url' do
      it { expect(build(:profile, fb_id: 'youcune').facebook_url).to eq 'https://www.facebook.com/youcune' }
    end

    describe '#facebook_short_url' do
      it { expect(build(:profile, fb_id: 'youcune').facebook_short_url).to eq 'fb.com/youcune' }
    end

    describe '#gender_str' do
      it { expect(build(:profile, gender: 'male').gender_str).to eq '男性' }
      it { expect(build(:profile, gender: 'female').gender_str).to eq '女性' }
      it { expect(build(:profile, gender: nil).gender_str).to eq 'データなし' }
    end

    describe '#age_str' do
      it { expect(build(:profile, age: 25).age_str).to eq '25歳' }
      it { expect(build(:profile, age: nil).age_str).to eq 'データなし' }
    end
    
    describe '#relationship_status_str' do
      it { expect(build(:profile, relationship_status: 'Single').relationship_status_str).to eq '独身' }
      it { expect(build(:profile, relationship_status: 'In A Relationship').relationship_status_str).to eq '交際中' }
      it { expect(build(:profile, relationship_status: 'Engaged').relationship_status_str).to eq '婚約中' }
      it { expect(build(:profile, relationship_status: 'Married').relationship_status_str).to eq '既婚' }
      it { expect(build(:profile, relationship_status: 'It\'s Complicated').relationship_status_str).to eq '複雑な関係' }
      it { expect(build(:profile, relationship_status: 'In An Open Relationship').relationship_status_str).to eq 'オープンな関係' }
      it { expect(build(:profile, relationship_status: 'Widowed').relationship_status_str).to eq 'データなし' }
      it { expect(build(:profile, relationship_status: 'Separated').relationship_status_str).to eq 'データなし' }
      it { expect(build(:profile, relationship_status: 'Divorced').relationship_status_str).to eq 'データなし' }
      it { expect(build(:profile, relationship_status: nil).relationship_status_str).to eq 'データなし' }
    end
  end
end
