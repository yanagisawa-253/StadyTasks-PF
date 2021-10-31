# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  describe '投稿一覧画面のテスト' do
    let(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    let!(:task) { create(:task, user: user) }
    let!(:other_task) { create(:task, user: other_user) }

    before do
      visit tasks_path
    end
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/tasks'
      end
      it '自分の投稿と他人の投稿のタイトルのリンク先がそれぞれ正しい' do
        expect(page).to have_link  href: task_path(task)
        expect(page).to have_link  href: task_path(other_task)
      end
    end
    context '投稿成功のテスト' do
      # before do
      #   fill_in '', with: Faker::Lorem.characters(number: 20)
      #   fill_in '', with: Faker::Lorem.characters(number: 50)
      #   click_button 'タスクを投稿'
      #   expect(page).to have_current_path task_path(Task.last)
      # end

      it '自分の新しい投稿が正しく保存される' do
        expect { click_button 'タスクを投稿する' }.to change(user.tasks, :count).by(1)
      end
      it 'リダイレクト先が、保存できた投稿の詳細画面になっている' do
        click_button 'タスクを投稿する'
        expect(current_path).to eq '/tasks/' + Task.last.id.to_s
      end
      it '投稿ボタンが表示されているか' do
        expect(page).to have_button 'タスクを投稿'
      end
    end
  end
end