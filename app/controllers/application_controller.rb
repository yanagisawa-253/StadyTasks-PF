class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # ログイン後プロフィール画面へ
  def after_sign_in_path_for(resources)
    user_path(current_user.id)
  end
  # 登録後はタスク一覧ページに
  def after_sign_up_path_for(resources)
    tasks_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

end