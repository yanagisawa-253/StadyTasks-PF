module NotificationsHelper

  def notification_form(notification)
  #通知を送ってきたユーザーを取得
    @visitor = notification.visitor
    #コメントの内容を通知に表示する
    @comment = nil
    @visitor_comment = notification.comment
    # notification.actionがfollowかlikeかcommentかで処理を変える
    case notification.action
    when 'like'
      tag.a(notification.visitor.name, href: user_path(@visitor)) + 'が' + tag.a('あなたの投稿', href: task_path(notification.task_id)) + 'にいいねしました'
    when 'comment' then
      #コメントの内容と投稿のタイトルを取得
      @comment = Comment.find_by(id: @visitor_comment)
      @comment_content =@comment.content
      @task_title =@comment.task.title
      tag.a(@visitor.name, href: user_path(@visitor)) + 'が' + tag.a("#{@task_title}", href: task_path(notification.task_id)) + 'にコメントしました'
    end
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
