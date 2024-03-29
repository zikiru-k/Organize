class Admin::BookmarksController < ApplicationController
  before_action :authenticate_admin!

  def create
    @comment = Comment.find(params[:comment_id])
    bookmark = current_customer.bookmarks.new(comment_id: @comment.id)
    bookmark.save
    render 'btn'
  end

  def destroy
    @comment = Comment.find(params[:comment_id])
    bookmark = current_customer.bookmarks.find_by(comment_id: @comment.id)
    bookmark.destroy
    render 'btn'
  end
end
