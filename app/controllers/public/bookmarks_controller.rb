class Public::BookmarksController < ApplicationController

  def create
    @comment = Comment.find(params[:id])
    bookmark = current_customer.bookmark.new(comment_id: @comment.id)
    bookmark.save
    # redirect_to request.referer
  end

  def destroy
    @comment = Comment.find(params[:id])
    bookmark = current_customer.bookmark.new(comment_id: @comment.id)
    bookmark.destroy
    # redirect_to request.referer
  end
end
