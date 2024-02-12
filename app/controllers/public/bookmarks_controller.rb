class Public::BookmarksController < ApplicationController

  def create
    @comment = Comment.find(params[:comment_id])
    bookmark = current_customer.bookmarks.new(comment_id: @comment.id)
    bookmark.save
    render 'btn'
    # redirect_to request.referer
  end

  def destroy
    @comment = Comment.find(params[:comment_id])
    bookmark = current_customer.bookmarks.find_by(comment_id: @comment.id)
    bookmark.destroy
    render 'btn'
    # redirect_to request.referer
  end
end
