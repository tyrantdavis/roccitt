require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:name) { RandomData.random_sentence  }
  let(:description) { RandomData.random_paragraph  }
  let(:title) { RandomData.random_sentence  }
  let(:body) {  RandomData.random_paragraph  }

  let(:topic) { Topic.create!( name: name, description: description  )  }
  let(:user) { User.create!(name: "Rooccitt User", email: "user@roccitt.com", password: "helloworld") }
  let(:post) { topic.posts.create!(title: title, body: body, user: user) }

   it { is_expected.to have_many(:comments) }
   it { is_expected.to have_many(:votes) }
  it { should belong_to( :topic  )  }
  it { should belong_to(:user) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:topic) }
  it { should validate_presence_of(:user) }
  

  it { should validate_length_of(:title).is_at_least(5).on(:create) }
  it { should validate_length_of(:body).is_at_least(20).on(:create) }


  describe "attributes" do
    it "has a title attribute" do
      expect(post).to have_attributes( title: title )
    end
    
    it "has a body attribute" do
      expect(post).to have_attributes( body: body  )
    end

    it "has a user attribute" do
      expect(post).to have_attributes( user: user  )
    end
  end

   describe "voting" do
 # #5
     before do
       3.times { post.votes.create!(value: 1) }
       2.times { post.votes.create!(value: -1) }
       @up_votes = post.votes.where(value: 1).count
       @down_votes = post.votes.where(value: -1).count
     end
 
 # #6
     describe "#up_votes" do
       it "counts the number of votes with value = 1" do
         expect( post.up_votes ).to eq(@up_votes)
       end
     end
 
 # #7
     describe "#down_votes" do
       it "counts the number of votes with value = -1" do
         expect( post.down_votes ).to eq(@down_votes)
       end
     end
 
 # #8
     describe "#points" do
       it "returns the sum of all down and up votes" do
         expect( post.points ).to eq(@up_votes - @down_votes)
       end
     end
   end

     describe "#update_rank" do
 # #28
       it "calculates the correct rank" do
         post.update_rank
         expect(post.rank).to eq (post.points + (post.created_at - Time.new(1970,1,1)) / 1.day.seconds)
       end
 
       it "updates the rank when an up vote is created" do
         old_rank = post.rank
         post.votes.create!(value: 1)
         expect(post.rank).to eq (old_rank + 1)
       end
 
       it "updates the rank when a down vote is created" do
         old_rank = post.rank
         post.votes.create!(value: -1)
         expect(post.rank).to eq (old_rank - 1)
       end
     end
end
