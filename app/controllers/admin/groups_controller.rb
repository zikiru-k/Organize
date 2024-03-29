class Admin::GroupsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @groups = Group.all.page(params[:page]).per(9)
  end

  def show
    @group = Group.find(params[:id])
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      flash[:notice] = "グループ情報を更新しました。"
      redirect_to admin_group_path
    else
      render :edit
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :content)
  end
end
