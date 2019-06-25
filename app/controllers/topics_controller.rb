class TopicsController < ApplicationController
   before_action :require_sign_in, except: [:index, :show]
   before_action :authorize_user, except: [:index, :show]


  def index
    @topics = Topic.all
  end
  
  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end
  
  def create
    @topic = Topic.new(topic_params)

    if @topic.save
      flash[:notice] = "Topic successfully created"
      redirect_to @topic
    else
      flash.now[:alert] = "Something went wrong saving the topic. Please try again."
      render :new
    end
  end
  
  def edit
    @topic = Topic.find(params[:id])
  end
  
  def update
    @topic = Topic.find(params[:id])
    @topic.assign_attributes(topic_params)

    if @topic.save
      flash[:notice] = "Topic updated."
      redirect_to @topic
    else
      flash.now[:alert] = "Something went wrong updating the topic. Please try again."
      render :edit
    end
  end
  
  def destroy
    @topic = Topic.find(params[:id])
    if @topic.destroy
      flash[:success] = 'Topic "#{@topic.name}"  was successfully deleted.'
      redirect_to topics_url
    else
      flash[:error] = 'Something went wrong'
      render :show
    end
  end
  
  private
  def topic_params
     params.require(:topic).permit(:name, :description, :public)
  end
 
 # #9
   def authorize_user
     unless current_user.admin?
       flash[:alert] = "You must be an admin to do that."
       redirect_to topics_path
     end
   end
end
