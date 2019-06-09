require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { Post.create!( title: "New Post Title", body: "New Post Body"  )  }

  describe "attributes" do
    it "has a title attribute" do
      expect(post).to have_attributes( title: "New Post Title"  )
    end
    
    it "has a body attribute" do
      expect(post).to have_attributes( body: "New Post Body"  )
    end
  end
end
