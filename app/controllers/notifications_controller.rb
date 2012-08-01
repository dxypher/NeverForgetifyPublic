class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications
  end

  def new
    @notification = Notification.new
  end

  def create
    notification = Notification.new(params[:notification])
    
    notification.user = current_user
    notification.save
    redirect_to notifications_path
  end

  def destroy
    notification = Notification.find(params[:id]).destroy
    redirect_to notifications_path
  end

  def edit
    @notification = Notification.find(params[:id])
  end

  def update
    @notification = Notification.find(params[:id])
    @notification.update_attributes(params[:notification])
    redirect_to root_path
  end
end
