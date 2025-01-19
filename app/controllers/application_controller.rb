class ApplicationController < ActionController::Base

  before_action :configure_authentication

  private
 
  def configure_authentication
    if admin_controller?
      authenticate_admin!
    else
      authenticate_user! unless action_is_public?
    end
  end
 
  def admin_controller?
    self.class.module_parent_name == 'Admin'#現在のコントローラークラスが"Admin"モジュールに属していれば　true
  end
 
  def action_is_public?
    controller_name == 'homes' && %w[top about].include?(action_name) #homes#topとhomes#aboutは認証が不要
  end

end