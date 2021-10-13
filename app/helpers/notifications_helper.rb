module NotificationsHelper
  # 通知内容によって、表示内容を分岐
  def notification_form(notification)
    @visitor = notification.visitor
    @comment = nil
    your_task = link_to 'あなたの投稿', task_path(notification), style:"font-weight: bold;"
    @visiter_comment = notification.comment
    # アクションごとに分岐
    case notification.action
      when "like" then
        tag.a(notification.visitor.name, href:user_path(@visitor), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:task_path(notification.task_id), style:"font-weight: bold;")+"にいいねしました"
      when "comment" then
        @comment = Comment.find_by(id: @visiter_comment)&.content
        tag.a(@visitor.name, href:user_path(@visitor), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:task_path(notification.task_id), style:"font-weight: bold;")+"にコメントしました"
    end
  end

  # 未確認の通知を示す
  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end

end



