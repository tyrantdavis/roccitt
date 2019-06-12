require 'rails_helper'

RSpec.describe TopicsController, type: :controller do
  let(:new_topic) { Topic.create!( 
    name: RandomData.random_sentence, 
    description: RandomData.random_paragraph,
    public: true
    )  }

  # let(:new_topic)  { Post.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph) }

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
