class Api::NotificationsController < ApplicationController
  
  def index
    notifications = current_user.notifications
    render :json => {notifications: notifications.collect{|n| n.api_attributes}} 
    
  end
  
  def show
    notification = Notification.find(params[:id])
    render :json => notification.full_api_attributes
  end
end
