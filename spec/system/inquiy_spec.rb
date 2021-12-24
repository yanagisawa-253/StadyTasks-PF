# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  describe 'お問合せ機能' do
    before do
      visit inquiry_path
    end
    describe '入力画面について' do
      context '表示の確認' do
        it 'URLがあっているか' do
          expect(current_path).to eq '/inquiry'
        end
        it 'タイトル「お問い合わせ」があるか' do
          expect(page).to have_content 'お問い合わせ'
        end
        it 'nameフィールドがあるか' do
          expect(page).to have_field 'inquiry[name]'
        end
        it 'emailフィールドがあるか' do
          expect(page).to have_field 'inquiry[email]'
        end
        it 'messegeフィールドがあるか' do
          expect(page).to have_field 'inquiry[message]'
        end
        it '確認ボタンがあるか' do
          expect(page).to have_button '確認'
        end
      end

      context 'フォームの確認' do
        it '確認ボタンが押せるか' do
          fill_in 'inquiry[name]', with: Faker::Lorem.characters(number:5)
          fill_in 'inquiry[email]', with: Faker::Internet.email
          fill_in 'inquiry[message]', with: Faker::Lorem.characters(number:20)
          click_button '確認'
          expect(page).to have_current_path inquiry_confirm_path
        end
      end
    end
  end
end