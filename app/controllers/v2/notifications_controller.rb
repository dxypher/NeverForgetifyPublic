class V2::NotificationsController < ApplicationController
  def show
    @notification_id = params[:id]
  end
end
