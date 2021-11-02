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

    context '表示内容の確認' do
      before do
        visit tasks_path
      end
      it 'URLが正しい' do
        expect(current_path).to eq '/tasks'
      end
      it '自分の投稿と他人の投稿のタイトルのリンク先がそれぞれ正しい' do
        expect(page).to have_link  href: task_path(task)
        expect(page).to have_link  href: task_path(other_task)
      end
    end
  end

  describe '投稿のテスト' do
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
    end
    let(:user) { create(:user) }
    context '表示の確認' do
      before do
        visit new_task_path
      end
      it 'tasks_new_pathが"/tasks/new"であるか' do
        expect(current_path).to eq('/tasks/new')
      end
      it 'titleフォームの設置があるか' do
        expect(page).to have_field 'task[title]'
      end
      it 'titleフォームに値が入っていない' do
        expect(find_field('task[title]').text).to be_blank
      end
      it 'bodyフォームの設置があるか' do
        expect(page).to have_field 'task[body]'
      end
      it 'bodyフォームに値が入っていない' do
        expect(find_field('task[body]').text).to be_blank
      end
      it '投稿ボタンが表示されているか' do
        expect(page).to have_button 'タスクを投稿する'
      end
    end
    context '実際に投稿テストを行う' do
      before do
        visit new_task_path
        fill_in 'task[title]', with: Faker::Lorem.characters(number:20)
        fill_in 'task[body]', with: Faker::Lorem.characters(number:50)
      end

      it '自分の新しい投稿が正しく保存される' do
        expect { click_button 'タスクを投稿する' }.to change(user.tasks, :count).by(1)
      end
      it 'リダイレクト先が、投稿一覧画面になっている' do
        click_button 'タスクを投稿する'
        expect(current_path).to eq('/tasks')
      end
    end
  end

  describe "詳細画面のテスト" do
    let(:user) { create(:user) }
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
    end
    let!(:task) { create(:task, user: user) }
    context '表示内容の確認' do
      before do
        visit task_path(task)
      end
      it 'URLが正しい' do
        expect(current_path).to eq '/tasks/' + task.id.to_s
      end
      it '編集画面へのリンクが存在' do
        expect(page).to have_link '', href: edit_task_path(task)
      end
      it '削除リンクが存在' do
        expect(page).to have_link '', href: task_path(task)
      end
      it 'コメント投稿フォームが表示されている' do
        expect(page).to have_content 'コメントを投稿する'
      end
    end
  end

  describe "編集画面のテスト" do
    let(:user) { create(:user) }
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
    end
    let!(:task) { create(:task, user: user) }
    context '表示内容の確認' do
      before do
        visit edit_task_path(task)
      end
      it 'URLがあっているか' do
        expect(current_path).to eq '/tasks/' + task.id.to_s + '/edit'
      end
      it 'タイトルが表示される' do
        expect(page).to have_content 'タスクを編集する'
      end
      it 'titleフォームの編集前の設置があるか' do
        expect(page).to have_field 'task[title]'
      end
      it 'bodyフォームの編集前の設置があるか' do
        expect(page).to have_field 'task[body]'
      end
      it 'ステータス表示' do
        expect(page).to have_content 'ステータスを更新する'
      end
      it 'タスクを投稿するボタンが表示される' do
        expect(page).to have_button 'タスクを投稿する'
      end
    end

    context '更新テスト' do
      before do
        visit edit_task_path(task)
      end
      it '更新できるか' do
        fill_in 'task[title]', with: Faker::Lorem.characters(number:5)
        fill_in 'task[body]', with: Faker::Lorem.characters(number:20)
        click_button 'タスクを投稿する'
        expect(page).to have_current_path tasks_path
      end
    end
  end
end
