class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications
    @notifications = @notifications.page(params[:page]).per(10)
    @notification = Notification.new
    flash[:notice] = "hello"
  end

  def new
    @ajax_post = false
    @notification = Notification.new
  end
  
  def show
    @notification = Notification.find(params[:id])
  end
  def create
    notification = Notification.new(params[:notification])
    
    notification.user = current_user
    if notification.save
      respond_to do |format|
        format.html{redirect_to notifications_path}
        format.json{
          render :json => {status: "success", notification: notification.full_api_attributes}
        }
      end
    else
      respond_to do |format|
        format.html{redirect_to new_notifications_path, :notice => notification.errors}
        format.json{
          render :json => {status: "error", errors: notification.errors}
        }
      end
    end
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
