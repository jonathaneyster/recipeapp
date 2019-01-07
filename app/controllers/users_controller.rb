class UsersController < ApplicationController
 before_action :require_same_user, only: [:edit, :update, :destroy]
 before_action :require_admin, only: [:destroy]
 before_action :set_user, only: [:show]
 
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome #{@user.name} to MyRecipesApp"
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
    if !@user.admin?
      @user.destroy
      flash[:danger] = "User and all recipes have been deleted"
      redirect_to users_path
    else
      
    end  
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def require_same_user
    if current_user != @user and !current_user.admin?
      flash[:danger] = "You can only edit or delete your own account"
      redirect_to users_path
    else
      
    end  
  end
  
  def require_admin
    if logged_in && !current_user.admin?
      flash[:danger] = "Only admin users can perform this action"
      redirect_to root_path
    else
      
    end  
  end  
  
  def set_user
    @user = User.find(params[:id])
  end  
end  