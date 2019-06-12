require 'rails_helper'

RSpec.describe TopicsController, type: :controller do
  let(:new_topic) { Topic.create!( 
    name: RandomData.random_sentence, 
    description: RandomData.random_paragraph,
    public: true
    )  }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns new_topic to @topics" do
      get :index
      expect(assigns(:topics)).to eq([new_topic])
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end
    
    it "instantiates @topic" do
      get :new
      expect(assigns(:topic)).not_to be_nil  
    end
  end

    describe "Topic create" do
      it "increases the number of Topics by 1" do
        expect{post :create, params: { topic: {name: RandomData.random_sentence, description: RandomData.random_paragraph, public: true}}}.to change(Topic,:count).by(1)
      end

    it "assigns the new topic to @topic" do
        post :create, params: { topic: {name: RandomData.random_sentence, description: RandomData.random_paragraph, public: true }}
        expect(assigns(:topic)).to eq Topic.last  
    end

    it "redirects to the new topic" do
        post :create, params: { topic: {name: RandomData.random_sentence, description: RandomData.random_paragraph, public: true }}
        expect(response).to redirect_to Topic.last  
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: {id: new_topic.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, params: {id: new_topic.id}
      expect(response).to render_template :show  
    end

    it "assigns new_topic to @topic" do
      get :show, params: {id: new_topic.id}
      expect(assigns(:topic)).to eq(new_topic)  
    end
  end
  

  describe "GET #edit" do
    it "returns http success" do
      get :edit, params: {id: new_topic.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #edit view" do
      get :edit, params: {id: new_topic.id}
      expect(response).to render_template :edit
    end

    it "assigns topic to be updated to @topic" do
      get :edit,  params: {id: new_topic.id}

      topic_instance = assigns(:topic)

      expect(topic_instance.id).to eq new_topic.id
      expect(topic_instance.name).to eq new_topic.name
      expect(topic_instance.description).to eq new_topic.description
      expect(topic_instance.public).to eq new_topic.public
    end
  end


  describe "PUT update" do
    it "updates topic with expected attributes" do
      new_name = RandomData.random_sentence
      new_description = RandomData.random_paragraph
      public_or_private = true

      put :update,  params: {id: new_topic.id, topic: { name: new_name, description: new_description, public: public_or_private  }}

      updated_topic = assigns(:topic)
      expect(updated_topic.id).to eq new_topic.id  
      expect(updated_topic.name).to eq new_name
      expect(updated_topic.description).to eq new_description
      expect(updated_topic.public).to eq public_or_private
    end
  
    it "redirects to the updated topic" do
      new_name = RandomData.random_sentence
      new_description = RandomData.random_paragraph
      public_or_private = true

      put :update, params: { 
        id: new_topic.id, 
        topic: { name: new_name, 
        description: new_description,
        public: public_or_private
        }}
      expect(response).to redirect_to new_topic  
    end
  end

  describe "DELETE destroy" do
    it "deletes the topic" do
      delete :destroy, params: {id: new_topic.id}
      count = Topic.where({id: new_topic.id}).size
      expect(count).to eq 0  
    end
    
    it "redirects to the topic index" do
      delete :destroy, params: {id: new_topic.id}
      expect(response).to redirect_to topics_path  
    end
  end
end
