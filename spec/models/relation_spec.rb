require 'spec_helper'

describe Relation do
  before do
    create(:relation, fb_id_younger: '10', fb_id_older: '20')
    create(:relation, fb_id_younger: '20', fb_id_older: '30')
    create(:profile, fb_id: '20')
  end

  describe 'Validations' do
    it '重複する fb_id_younger, fb_id_older の組み合わせは invalid となる' do
      relation = build(:relation, fb_id_younger: '10', fb_id_older: '20')
      expect(relation).not_to be_valid
    end

    it 'fb_id_younger が重複しても fb_id_older が異なれば valid となる' do
      relation = build(:relation, fb_id_younger: '10', fb_id_older: '30')
      expect(relation).to be_valid
    end

    it 'fb_id_older が重複しても fb_id_younger が異なれば valid となる' do
      relation = build(:relation, fb_id_younger: '30', fb_id_older: '10')
      expect(relation).to be_valid
    end
  end

  describe 'Public Class Methods' do
    describe '#insert' do
      pending
    end

    describe '#common_friends' do
      it '共通の友人を返す' do
        common_friends = Relation.common_friends('10', '30')
        expect(common_friends.count).to eq 1
        expect(common_friends.first.fb_id).to eq '20'
      end

      it '共通の友人がいない場合は空の配列を返す' do
        common_friends = Relation.common_friends('10', '20')
        expect(common_friends).to be_empty
      end
    end

    describe '#store!' do
      context '重複しない場合' do
        it 'IDの若い方を fb_id_younger に格納する' do
          relation = Relation.store!('50', '40')
          expect(relation.fb_id_younger).to eq '40'
          expect(relation.fb_id_older).to eq '50'
        end

        it 'Relation の件数が1増える' do
          expect {
            Relation.store!('50', '40')
          }.to change(Relation, :count).by 1
        end
      end

      context '重複する場合' do
        it 'Relation の件数は変化しない' do
          expect {
            Relation.store!('20', '10')
          }.not_to change(Relation, :count)
        end
      end
    end
  end
end
