class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    customer = Customer.find(params[:id])
    if customer.update(customer_params)
      flash[:notice] = "会員情報を更新しました。"
      redirect_to admin_customer_path
    else
      flash[:notice] = "会員情報を更新に失敗しました。"
      render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email, :telephone_number, :is_active)
  end
end
