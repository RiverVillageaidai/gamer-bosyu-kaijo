class Admin::DashboardsController < ApplicationController

  layout 'admin' #/views/layouts/　にあるapplication.html.erbの代わりにadmin.html.erbを使用する

  before_action :authenticate_admin!
  def index
      @users = User.all
  end

end
