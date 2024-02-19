class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @tags = Tag.all
  end

  def destroy
    Tag.find(params[:id]).destroy()
    redirect_to request.referer
  end
end
