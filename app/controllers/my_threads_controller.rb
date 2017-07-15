class MyThreadsController < ApplicationController
  before_action :set_my_thread, only:[:edit, :show, :update, :destroy]
  before_action :authenticate_user!
  before_action :is_owner?, only:[:edit, :update, :destroy]
  def index
    @my_threads = MyThread.includes(:comments).all
  end

  def new
    @my_thread = MyThread.new
  end

  def create
    MyThread.create(my_thread_params)
    redirect_to my_threads_path
  end

  def edit
  end

  def show
    @comments = @my_thread.comments
  end

  def update
    @my_thread.update(my_thread_params)
  end

  def destroy
    @my_thread.delete
    redirect_to my_threads_path
  end

  private

  def set_my_thread
    @my_thread = MyThread.find(params[:id])
  end
  def my_thread_params
    params.require(:my_thread).permit(:title, :description).merge(user_id: current_user.id)
  end

  def is_owner?
    redirect_to my_threads_path unless current_user.id == @my_thread.user_id
  end

end
