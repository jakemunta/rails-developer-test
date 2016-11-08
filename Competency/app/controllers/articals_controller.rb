class ArticalsController < ApplicationController
  include Devise::Controllers::Helpers
  before_action :authenticate_user!, :except => [:index]
#  before_action :authenticate_or_signup, :except => [:index]
  before_action :find_artical, :only => [:edit, :update, :show, :delete]

   before_action :check_role, :except => [:index]

  def index 
    @articals = Artical.all
  end

  def new
    @artical = Artical.new
  end


  def create
    @artical = Artical.new(params_artical.merge(:user_id => current_user.id))
    if @artical.save
      flash[:notice] = "Successfully created Artical!!"
      redirect_to artical_path(@artical)
    else
      flash[:alert] = "Error creating new artical!!"
      render :new
    end

  end

  def edit
  end


  def update
    if @artical.update_attributes(params_artical.merge(:user_id => current_user.id))
      flash[:notice] = "Successfully updated Artical!!"
      redirect_to artical_path(@artical)
    else
      flash[:alert] = "Error in updating artical!!"
      render :edit
    end

  end

  def show
  end

  def destroy
   if @artical.destroy
      flash[:notice] = "Successfully deleted Artical!!"
      redirect_to articals_path
    else
      flash[:alert] = "Error in updating artical!!"

    end

  end

private 
  def check_role
     if current_user && current_user.vanilla? && params[:action] != 'show'
        redirect_to articals_path
     elsif current_user && current_user.editor? 
        if @artical && (params[:action] == 'edit' || params[:action] == 'destroy' || params[:action] == 'update') && (current_user.id != @artical.user_id) 
           redirect_to articals_path
        end
     elsif current_user && current_user.admin?
        redirect_to articals_path
     end
  end
  def authenticate_or_signup
    
  end
  def find_artical
    @artical = Artical.find(params[:id])
  end

  def params_artical
    params.require(:artical).permit(:title, :content, :category, :user_id)
  end
end

