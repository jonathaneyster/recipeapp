class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcom #{@user.name} to MyRecipesApp"
      redirect_to user_path(@user)
    else
      render 'new'
    end  
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile was updated successfully"
      redirect_to user_path(@user)
    else
      render 'edit'
    end  
  end    

  def show
    @user = User.find(params[:id])
    @user_recipes = @user.recipes.paginate(page: params[:page], per_page: 5)
  end  
  
  def edit
    @user = User.find(params[:id])
  end  
  
  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end  
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:danger] = "User and all recipes have been deleted"
    redirect_to users_path
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end  
end  