class Public::BookmarksController < ApplicationController
  before_action :authenticate_customer!,except: [:top]
  before_action :ensure_guest_customer
  
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
  
  private
  
  def ensure_guest_customer
   if current_customer.guest_customer?
     redirect_to top_path, notice: "新規登録をしてください"
   end
  end
end
