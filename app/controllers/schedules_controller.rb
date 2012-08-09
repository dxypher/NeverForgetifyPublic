class SchedulesController < ApplicationController
  def index
  @notification = Notification.find(params[:notification_id])
  end
  
  def destroy
    @notification = Notification.find(params[:notification_id])
    schedule = Schedule.find(params[:id]).destroy
    redirect_to notification_schedules_path(@notification)
  end
end
