class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
  end

  def destroy
    Tag.find(params[:id]).destroy()
    redirect_to admin_group_tags_path(params[:group_id])
  end
end
