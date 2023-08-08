class UsersController < ApplicationController
  def index
    @users = User.all
    @book = Book.new
    @user = User.find(current_user.id)
  end
  def show
    @books = Book.where(user_id: params[:id])
    @book = Book.new
    @user = User.find(params[:id])
  end
  def edit
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
    @user = User.find(current_user.id)
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id) 
    else
      render :edit
    end
  end
  def destroy

  end
  private
  

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
