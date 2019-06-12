require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:name) { RandomData.random_sentence  }
  let(:description) { RandomData.random_paragraph  }
  let(:title) { RandomData.random_sentence  }
  let(:body) {  RandomData.random_paragraph  }

  let(:topic) { Topic.create!( name: name, description: description  )  }
  let(:post) { topic.posts.create!( title: title, body: body  )  }

  it { should belong_to( :topic  )  }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:topic) }
  
  # is_at_least not behaving properly
  it { should validate_length_of(:title).is_at_least(5).on(:create) }
  it { should validate_length_of(:body).is_at_least(20).on(:create) }


  describe "attributes" do
    it "has a title attribute" do
      expect(post).to have_attributes( title: title )
    end
    
    it "has a body attribute" do
      expect(post).to have_attributes( body: body  )
    end
  end
end
