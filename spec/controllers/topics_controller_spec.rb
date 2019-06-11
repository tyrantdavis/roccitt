require 'rails_helper'

RSpec.describe TopicsController, type: :controller do
  let(:new_topic) { Topic.create!( 
    name: RandomData.random_sentence, 
    description: RandomData.random_paragraph,
    public: true
    )  }

  # let(:new_post)  { Post.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph) }

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
end
