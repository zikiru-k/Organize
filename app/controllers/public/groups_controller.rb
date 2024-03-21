class Public::GroupsController < ApplicationController
  before_action :authenticate_customer!,except: [:top]
  before_action :ensure_current_customer_owner, only:[:edit, :update]
  before_action :ensure_guest_customer, only:[:show, :new, :create, :edit, :update]

  def index
    @groups = Group.all.page(params[:page]).per(9)
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    group = Group.new(group_params)
    group.owner_id = current_customer.id
    group.permit_id = current_customer.id
    if group.save
      flash[:notice] = "グループを作成しました。"
      redirect_to groups_path, method: :post
    else
      flash.now[:alert] = "グループの作成に失敗しました。"
      render :new
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      flash[:notice] = "変更内容を保存しました。"
      redirect_to group_path
    else
      flash.now[:alert] = "変更内容を保存できませんでした。"
      render :edit
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :content)
  end

  def ensure_current_customer_owner
    @group = Group.find(params[:id])
    unless @group.owner_id == current_customer.id
      redirect_to groups_path
    end
  end
end
