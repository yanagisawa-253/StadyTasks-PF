# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'Taskモデルト', type: :model do

  subject { task.valid? }

  let(:task) { FactoryBot.build(:task) }

  describe 'バリデーションのテスト' do
    context 'titleカラム' do
      it '空欄でないこと' do
        task.title = ''
        is_expected.to eq false
      end
    end

    context 'bodyカラム' do
      it '空欄ではないこと' do
        task.body = ''
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Commentモデルとの関係' do
      it '1:Nとなっている' do
        expect(Task.reflect_on_association(:comments).macro).to eq :has_many
      end
    end
    context 'Likeモデルとの関係' do
      it '1:Nとなっている' do
        expect(Task.reflect_on_association(:likes).macro).to eq :has_many
      end
    end
    context 'Notificationモデルとの関係' do
      it '1:Nとなっている' do
        expect(Task.reflect_on_association(:notifications).macro).to eq :has_many
      end
    end
  end
end