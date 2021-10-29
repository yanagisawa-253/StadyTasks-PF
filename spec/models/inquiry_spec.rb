# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'Inquiryモデル', type: :model do
  describe 'バリデーションのテスト' do

    subject { inquiry.valid? }

    let(:inquiry) { FactoryBot.build(:inquiry) }

    context 'nameカラム' do
      it "名前が空ではない" do
        inquiry.name = ''
        is_expected.to eq false
      end
    end

    context 'emailカラム' do
      it "emailが空ではない" do
        inquiry.email = ''
        is_expected.to eq false
      end
    end

    context 'messageカラム' do
      it "messageが空ではない" do
        inquiry.message = ''
        is_expected.to eq false
      end
    end
  end
end