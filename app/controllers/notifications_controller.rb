class NotificationsController < ApplicationController
  before_filter :authenticate_user! #, :except => [:show, :index]
  before_filter :get_current_notification, only: [:show, :edit, :update, :destroy]

  def index
    @notifications = current_company.notifications

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @notifications }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @notifications }
    end
  end

  def new
    @notification = current_user.notifications.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @notification }
    end
  end

  def create
    @notification = current_user.notifications.build(notification_params)
    @notification.company = current_company

    respond_to do |format|
      if @notification.save
        format.html { redirect_to @notification, notice: 'The Notification was created correctly.' }
        format.json { render json: @notification, status: :created, location: @notification }
      else
        format.html { render action: "new" }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @notification.update_attributes(notification_params)
        format.html { redirect_to @notification, notice: 'The Notification was updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @notification.destroy

    respond_to do |format|
      format.html { redirect_to notifications_url, notice: 'The Notification was deleted.' }
      format.json { head :no_content }
    end
  end

  protected
  def get_current_notification
    @notification = current_user.notifications.find(params[:id])
  end

  private
  def notification_params
    params.require(:notification).permit(:reason, :scheduled_on)
  end
end
