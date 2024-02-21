class Public::GroupUsersController < ApplicationController
  before_action :authenticate_customer!,except: [:top]
  before_action :ensure_guest_customer

  def create
    group_customer = current_customer.group_users.new(group_id: params[:group_id])
    group_customer.save
    redirect_to request.referer
  end

  def destroy
    group_customer = current_customer.group_users.find_by(group_id: params[:group_id])
    group_customer.destroy
    redirect_to request.referer
  end

  private

  def ensure_guest_customer
   if current_customer.guest_customer?
     redirect_to top_path, notice: "新規登録をしてください。"
   end
  end
end
