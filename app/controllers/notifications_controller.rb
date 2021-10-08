class NotificationsController < ApplicationController
  before_action :authenticate_user!
  def index
    #　通知の表示、画面を開いたら開封済みに
      @notifications = current_user.passive_notifications
      @notifications.where(checked: false).each do |notification|
        notification.update_attributes(checked: true)
      end
  end

  def destroy
    @notifications = current_user.passive_notifications.destroy_all
    redirect_to notifications_path
  end
end
