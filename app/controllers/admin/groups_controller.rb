class Admin::GroupsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    group = Group.find(params[:id])
    if group.update(group_params)
      redirect_to admin_group_path, notice: "グループ情報を更新しました。"
    else
      render :edit, notice: "グループ情報を更新に失敗しました。"
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :content)
  end
end
