class Public::NotificationsController < ApplicationController
  before_action :authenticate_customer!,except: [:top]
  before_action :ensure_guest_customer

  def update
    notification = current_customer.notifications.find(params[:id])
    notification.update(read: true)
    redirect_to notification.notifiable_path
  end

  def index
    @notifications = current_customer.notifications.order(created_at: :desc).page(params[:page]).per(20)
    @notifications.where(read: false).each do |notification|
      notification.update(read: true)
    end
  end

  def destroy
    @notifications = current_end_customer.notifications.destroy_all
    redirect_to notifications_path
  end

  private

  def ensure_guest_customer
   if current_customer.guest_customer?
     redirect_to top_path, notice: "新規登録をしてください。"
   end
  end
end
