class Task < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :notifications, dependent: :destroy

  def like_by?(user)
    likes.where(user_id: user.id).exists?
  end

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

  def create_notification_by(current_user)
    notification = current_user.active_notifications.new(
      task_id: id,
      visited_id: user_id,
      action: 'comment'
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  validates :title, {presence: true, length: { maximum: 20 }}
  validates :body, {presence: true, length: { maximum: 50 }}
end
