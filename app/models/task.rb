class Task < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :notifications, dependent: :destroy

  # すでにいいねをしているのかどうかを判定
  def like_by?(user)
    likes.where(user_id: user.id).exists?
  end
  
  # いいね機能通知レコード
  def create_notification_like!(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and task_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
    # いいねされていない場合のみ通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        task_id: id,
        visited_id: user_id,
        action: 'like'
      )
      # 自分の投稿に対するいいねは通知済み
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  # def create_notification_by(current_user)
  #   notification = current_user.active_notifications.new(
  #     task_id: id,
  #     comment_id: comment_id,
  #     visited_id: visited_id,
  #     visited_id: user_id,
  #     action: 'comment'
  #   )
  #   # 自分の投稿に対するコメントは通知済みとする
  #   if notification.visitor_id == notification.visited_id
  #     notification.checked = true
  #   end
  #   notification.save if notification.valid?
  # end

  # コメント機能通知コード
  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(task_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      task_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visiter_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  validates :title, :presence => {:message => 'タイトルを入力してください'}
  validates :body, :presence => {:message => '本文を入力してください'}
end
