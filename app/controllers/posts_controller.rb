class PostsController < ApplicationController
  before_action :require_sign_in, except: :show
  def show
    @post = Post.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
  end

  def create
    @post = Post.new
    @post.title = params[:post][:title]
    @post.body = params[:post][:body]
    @topic = Topic.find(params[:topic_id])

    @post.topic = @topic

    if @post.save
      flash[:notice] = "Post successfully created"
      redirect_to [@topic, @post]
    else
      flash.now[:alert] = "Something went wrong saving the post. Please try again."
      render 'new'
    end
  end
  

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.title = params[:post][:title]
    @post.body = params[:post][:body]

    if @post.save
      flash[:notice] = "Post successfully updated"
      redirect_to [@post.topic, @post]
    else
      flash.now[:alert] = "Something went wrong updating the post. Please try again."
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:success] = 'Post "#{@post.title}" was successfully deleted.'
      redirect_to @post.topic
    else
      flash[:error] = 'Something went wrong deleting the post.'
      render :show
    end
  end
  
end
