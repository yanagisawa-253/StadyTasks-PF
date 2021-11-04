# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  describe 'コメントのテスト' do
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
    end
    let(:user) { create(:user) }

    context '表示の確認' do
      let!(:task) { create(:task, user: user) }
      before do
        visit task_path(task)
      end

      it 'タイトルが表示されるか' do
        expect(page).to have_content 'コメントを投稿する'
      end
      it 'コメントフォームがあるか' do
        expect(page).to have_field 'comment[comment]'
      end
      it '送信ボタンがあるか' do
        expect(page).to have_button '送信'
      end
    end

    context 'コメント送信' do
      let!(:task) { create(:task, user: user) }
      before do
        visit task_path(task)
      end
      it '送信できる' do
        fill_in 'comment[comment]', with: Faker::Lorem.characters(number:20)
        click_button '送信'
        expect(page).to have_current_path task_path(task)
      end
      it '正しく保存されるか' do
        fill_in 'comment[comment]', with: Faker::Lorem.characters(number:20)
        expect { click_button '送信' }.to change(user.comments, :count).by(1)
      end
    end
  end
end