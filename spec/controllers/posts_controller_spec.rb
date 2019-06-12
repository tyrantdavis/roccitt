require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:new_topic) { Topic.create!( 
    name: RandomData.random_sentence, 
    description: RandomData.random_paragraph,
    )  }
  let(:new_post)  { 
    new_topic.posts.create!(
      title: RandomData.random_sentence, 
      body: RandomData.random_paragraph
      ) }

  describe "GET #new" do
    it "returns http success" do
      get :new, params: { topic_id: new_topic.id  }
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new, params: { topic_id: new_topic.id  }
      expect(response).to render_template :new
    end
    
    it "instantiates @post" do
      get :new, params: { topic_id: new_topic.id  }
      expect(assigns(:post)).not_to be_nil  
    end
  end

    describe "POST create" do
      it "increases the number of Post by 1" do
        expect{post :create, params: {
          topic_id: my_topic.id, 
          post: {
            title: RandomData.random_sentence, 
            body: RandomData.random_paragraph}}}.to change(Post, :count).by(1)
      end

    it "assigns the new post to @post" do
        post :create, params: { 
          topic_id: my_topic.id,
          post: {
            title: RandomData.random_sentence, 
            body: RandomData.random_paragraph}}
        expect(assigns(:post)).to eq Post.last  
    end
    
    it "redirects to the new post" do
        post :create, params: { 
          topic_id: my_topic.id,
          post: {
            title: RandomData.random_sentence, body: RandomData.random_paragraph}}
        expect(response).to redirect_to [ new_topic, Post.last  ]
    end
  end
  

  describe "GET #show" do
    it "returns http success" do
      get :show, params: {topic_id: new_topic.id  id: new_post.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, params: {topic_id: new_topic.id, id: new_post.id}
      expect(response).to render_template :show  
    end

    it "assigns new_post to @post" do
      get :show, params: {topic_id: new_topic.id,  id: new_post.id}
      expect(assigns(:post)).to eq(new_post)  
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, params: {id: new_post.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #edit view" do
      get :edit, params: {id: new_post.id}
      expect(response).to render_template :edit
    end

    it "assigns post to be updated to @post" do
      get :edit,  params: {id: new_post.id}

      post_instance = assigns(:post)

      expect(post_instance.id).to eq new_post.id
      expect(post_instance.title).to eq new_post.title
      expect(post_instance.body).to eq new_post.body
    end
  end

  describe "PUT update" do
    it "updates post with expected attributes" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph

      put :update,  params: {id: new_post.id, post: { title: new_title, body: new_body  }}

      updated_post = assigns(:post)
      expect(updated_post.id).to eq new_post.id  
      expect(updated_post.title).to eq new_title
      expect(updated_post.body).to eq new_body
    end
  
    it "redirects to the updated post" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph

      put :update, params: { 
        id: new_post.id, 
        post: { title: new_title, 
        body: new_body  }}
      expect(response).to redirect_to new_post  
    end
  end
  
  describe "DELETE destroy" do
    it "deletes the post" do
      delete :destroy, params: {id: new_post.id}
      count = Post.where({id: new_post.id}).size
      expect(count).to eq 0  
    end
    
    it "redirects to the post index" do
      delete :destroy, params: {id: new_post.id}
      expect(response).to redirect_to posts_path  
    end
    
  end
  

end
