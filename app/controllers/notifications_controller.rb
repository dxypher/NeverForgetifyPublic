class NotificationsController < ApplicationController
  def index
    @notifications = Notification.all
  end

  def new
    @notification = Notification.new
  end

  def create
    notification = Notification.create(params[:notification])
    notification.user = current_user
    notification.save
    redirect_to notifications_path
  end

  def destroy
    notification = Notification.find(params[:id]).destroy
    redirect_to notifications_path
  end

  def edit
  end

  def update
  end
end
