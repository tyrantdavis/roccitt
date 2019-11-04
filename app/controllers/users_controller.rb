class UsersController < ApplicationController
  def index
  #  Only accessible to and Added for Admin Dash
    @users = User.all.order(:name).paginate(page:params[:page], per_page: 5)
  end

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

   def show
     @user = User.find(params[:id])
     @posts = @user.posts.visible_to(current_user)
   end

  #  Only accessible to and Added for Admin Dash
  def destroy
   @user = User.find(params[:id])
    if@user.destroy
      flash[:success] = 'User "#{@user.name}"  was successfully deleted.'
      redirect_to users_url
    else
      flash[:error] = 'Something went wrong'
      render :show
    end
  end
  
  private
  def user_params
     params.require(:user).permit(:name, :email)
  end
 
 # #9
   def authorized_user
     unless current_user.admin?
       flash[:alert] = "You must be an admin to do that."
       redirect_to topics_path
     end
   end
end
