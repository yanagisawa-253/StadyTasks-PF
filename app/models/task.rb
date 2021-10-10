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


  def create_notification_comment!(current_user, comment_id)
    # （ログイン中の会員と投稿者以外で）同じ投稿にコメントしているユーザーに通知を送る
    temp_ids = Comment.where(task_id: id).where.not('user_id=? or user_id=?', current_user.id, user_id).select(:user_id).distinct
    # 取得したユーザーへの通知を作成
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # 投稿者へ通知を作成
    save_notification_comment!(current_user, comment_id, user_id)
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(
      task_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分が自分の投稿にコメントした時は通知済の扱いをする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  validates :title, :presence => {:message => 'タイトルを入力してください'}
  validates :body, :presence => {:message => '本文を入力してください'}
end
