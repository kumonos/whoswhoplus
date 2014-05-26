require 'spec_helper'

describe Relation do
  before do
    create(:relation, fb_id_from: '10', fb_id_to: '20')
    create(:relation, fb_id_from: '20', fb_id_to: '30')
    create(:profile, fb_id: '10')
    create(:profile, fb_id: '20')
    create(:profile, fb_id: '30')
  end

  describe 'Validations' do
    it '重複する fb_id_to, fb_id_from の組み合わせは invalid となる' do
      relation = build(:relation, fb_id_from: '10', fb_id_to: '20')
      expect(relation).not_to be_valid
    end

    it 'fb_id_from が重複しても fb_id_to が異なれば valid となる' do
      relation = build(:relation, fb_id_from: '10', fb_id_to: '30')
      expect(relation).to be_valid
    end

    it 'fb_id_to が重複しても fb_id_from が異なれば valid となる' do
      relation = build(:relation, fb_id_to: '30', fb_id_from: '10')
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

      it '共通の友人がいない場合は空の値を返す' do
        common_friends = Relation.common_friends('10', '20')
        expect(common_friends).to be_empty
      end
    end

    describe '#store!' do
      context '重複しない場合' do
        it 'fromに50が入り、toに40が入る' do
          relation = Relation.store!('50', '40')
          expect(relation.fb_id_from).to eq '50'
          expect(relation.fb_id_to).to eq '40'
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
            Relation.store!('10', '20')
          }.not_to change(Relation, :count)
        end
      end
    end
  end
end
