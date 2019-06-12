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
  

end
