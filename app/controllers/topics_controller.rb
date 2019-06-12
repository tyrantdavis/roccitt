class TopicsController < ApplicationController
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
    @topic = Topic.new
    @topic.name = params[:topic][:name]
    @topic.description = params[:topic][:description]
    @topic.public = params[:topic][:public]

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

    @topic.name = params[:topic][:name]
    @topic.description = params[:topic][:description]
    @topic.public = params[:topic][:public]

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
  
end
