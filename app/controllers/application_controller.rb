class ApplicationController < ActionController::Base
  before_action :get_latest_article

  # 全てのサイドバーにグループ一覧を表示するため
  def get_latest_article
    if customer_signed_in?
      @customer = current_customer
      @created_groups = Group.where(owner_id: current_customer.id)
      @join_groups = current_customer.group_users
    end
    # navに現在のグループ名を表示するため
    if params[:group_id].present?
      @current_group = Group.find(params[:group_id])
    end
  end

  def ensure_guest_customer
   if current_customer.guest_customer?
     redirect_to top_path, notice: "新規登録をしてください。"
   end
  end
end
