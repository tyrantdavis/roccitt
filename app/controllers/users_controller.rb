class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new
    @user.name = params[:user][:name]
    @user.email = params[:user][:email]
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]

    if @user.save
      flash[:notice] = "Welcome to Roccitt ship #{@user.name}!"
      
      # automatically signs user in after sign-up
      create_session(@user)
      
      redirect_to root_path
    else
      flash.now[:alert] = "Hi!. Something went creating your account. Please try again."
      render :new
    end
  end
end
