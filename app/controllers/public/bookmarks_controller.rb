class Public::BookmarksController < ApplicationController
  before_action :authenticate_customer!,except: [:top]
  before_action :ensure_guest_customer
  before_action :get_latest_article

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
