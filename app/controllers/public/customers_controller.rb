class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!,except: [:top]
  before_action :ensure_guest_customer
  before_action :get_latest_article

  def show
    @customer = current_customer
    @created_groups = Group.where(owner_id: current_customer.id)
    @join_groups = @customer.group_users
  end

  def edit
    @customer = current_customer
  end

  def update
    customer = Customer.find(current_customer.id)
    if customer.update(customer_params)
      redirect_to customers_mypage_path, notice: "変更内容を保存しました。"
    else
      render :edit
    end
  end

  def withdraw
    customer = Customer.find(current_customer.id)
    customer.update(is_active: false)
    reset_session
    redirect_to top_path, notice: "退会処理を実行いたしました。"
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email, :telephone_number)
  end
end
