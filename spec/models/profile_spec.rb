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

    describe '#name_with_link' do
      it { expect(build(:profile, fb_id: 'youcune', name: 'なかにしゆう').name_with_link).to eq '<a href="https://www.facebook.com/youcune" target="_blank">なかにしゆう</a>' }
    end


    describe '#facebook_url' do
      it { expect(build(:profile, fb_id: 'youcune').facebook_url).to eq 'https://www.facebook.com/youcune' }
    end

    describe '#gender_str' do
      it { expect(build(:profile, gender: 'male').gender_str).to eq '男性' }
      it { expect(build(:profile, gender: 'female').gender_str).to eq '女性' }
      it { expect(build(:profile, gender: nil).gender_str).to eq 'データなし' }
    end

    describe '#age_str' do
      it { expect(build(:profile, age: 25).age_str).to eq '25歳' }
      it { expect(build(:profile, gender: nil).age_str).to eq 'データなし' }
    end
    
    describe '#relationship_status_str' do
      it { expect(build(:profile, relationship_status: 'Single').relationship_status_str).to eq '独身' }
      it { expect(build(:profile, relationship_status: 'In A Relationship').relationship_status_str).to eq '交際中' }
      it { expect(build(:profile, relationship_status: 'Engaged').relationship_status_str).to eq '婚約中' }
      it { expect(build(:profile, relationship_status: 'Married').relationship_status_str).to eq '既婚' }
      it { expect(build(:profile, relationship_status: 'It\'s Complicated').relationship_status_str).to eq '複雑な関係' }
      it { expect(build(:profile, relationship_status: 'In An Open Relationship').relationship_status_str).to eq 'オープンな関係' }
      it { expect(build(:profile, relationship_status: 'Widowed').relationship_status_str).to eq '配偶者と死別' }
      it { expect(build(:profile, relationship_status: 'Separated').relationship_status_str).to eq '別居' }
      it { expect(build(:profile, relationship_status: 'Divorced').relationship_status_str).to eq '離婚' }
      it { expect(build(:profile, relationship_status: nil).relationship_status_str).to eq 'データなし' }
    end
  end
end
