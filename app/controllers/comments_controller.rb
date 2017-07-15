class CommentsController < ApplicationController
  before_action :set_my_thread
  before_action :set_comments, only:[:edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :is_owner?, only: [:edit, :update, :destroy]

  def new
    @comment = @my_thread.comments.new
  end

  def create
    @my_thread.comments.create(comment_params)
    redirect_to my_thread_path(@my_thread)
  end

  def edit
  end

  def update
    @comment.update(comment_params)
    redirect_to my_thread_path(@my_thread)
  end

  def destroy
    @comment.destroy
    redirect_to my_thread_path(@my_thread)
  end

  private

  def set_my_thread
    @my_thread = MyThread.find(params[:my_thread_id])
  end

  def set_comments
    @comment = @my_thread.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, my_thread_id: @my_thread.id)
  end

  def is_owner?
    redirect_to my_thread_path(@my_thread.id) unless current_user.id == @comment.user_id
  end
end
