class AdminSettingsController < ApplicationController
  before_action :logged_in_admin_user
  def index
  end

  def mail_setting
  end
end
