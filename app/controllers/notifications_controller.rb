class NotificationsController < ApplicationController
  before_action :authenticate_user!
  def index
    # 通知の表示画面を開いたら開封済みに
    @notifications = current_user.passive_notifications.page(params[:page]).per(10)
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end

  def destroy
    @notifications = current_user.passive_notifications.destroy_all
    redirect_to notifications_path
  end
end
