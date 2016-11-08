class Admin::UsersController < ApplicationController
   include Devise::Controllers::Helpers
   before_action :authenticate_user!

    before_action :find_user , :only => [:edit,:update,:destroy]

 before_action :check_role
   
   def index
      @users = User.all
      
   end

   def show
     @user = User.find(params[:id])
    end

   def new
    @user = User.new
   end
   
   def create
      @user = User.new(params_user)
      if @user.save
        @user.add_role params[:user][:role] if !params[:user][:role].empty?
         flash[:notice] = "User created successsfully !!"
        redirect_to admin_user_path(@user)
      else
        
          render :new
      end

    end


    def edit

    end
    
    def update
       if @user.update_attributes(params_user)
          @user.roles.collect{|r| r.name}.each{|m| u.remove_role m}
          @user.add_role params[:user][:role] if !params[:user][:role].empty?
         flash[:notice] = "User updated successsfully !!"
        redirect_to admin_user_path(@user)
      else
       
          render :edit
      end
    end
    
    def destroy
      if @user.destroy
         flash[:notice] = "User deleted successsfully !!"
        redirect_to admin_users_path
      else
         flash[:error] ="User can not be deleted !"
          redirect_to admin_users_path
      end
    end

private 
     def find_user
         @user = User.find(params[:id])
     end
     def params_user
         params.require(:user).permit(:email, :password, :role)
     end
     def check_role
        if !current_user.admin?
           redirect_to articals_path
        end
     end
end
