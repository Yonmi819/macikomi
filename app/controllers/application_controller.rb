class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    
    
  def after_sign_up_path_for(resource)
    user_root_path(resource)
  end
  
  
  def after_sign_out_path_for(resource)
    root_path
  end
  
  #管理者とユーザー側でログイン後の遷移画面を変更
  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_root_path
    when User
      user_root_path
    end
  end
  
    
  protected
    
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name,:first_name,:last_name_kana,:first_name_kana,:email,:password])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email,:password])
  end


end