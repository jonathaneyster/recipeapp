class TagsController < ApplicationController
  before_action :set_tag, only: [:edit, :update, :show]
  before_action :require_admin, except: [:show, :index]
  
  def new
    @tag = Tag.new
  end  
  
  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash[:success] = "Category was saved"
      redirect_to tag_path(@tag)
    else
      render 'new'
    end  
  end  
  
  def edit
    
  end
  
  def update
    if @tag.update(tag_params)
      flash[:success] = "Updated successfully"
      redirect_to @tag
    else
      render 'edit'
    end  
  end  
  
  def show 
     @tag_recipes = @tag.recipes.paginate(page: params[:page], per_page: 5)
  end  
  
  def index
    @tags = Tag.paginate(page: params[:page], per_page: 5)
  end
  
  private
  
  def set_tag
    @tag = Tag.find(params[:id])
  end  
  
  def tag_params
    params.require(:tag).permit(:name)
  end
  
  def require_admin
    if !logged_in || (logged_in && !current_user.admin?)
      flash[:danger] = "Only admins can perform this action"
      redirect_to tags_path
    else
    
    end  
  end  
end  