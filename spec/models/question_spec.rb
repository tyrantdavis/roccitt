require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question) { Question.create!( title: "New Question Title", body: "New Question Body", resolved: false  )  }
  
  let(:question2) { Question.create!( title: "Question 2  Title", body: "Question 2 Body", resolved: true  )  }

  describe "attributes" do
    it "responds to title attribute" do
      expect(question).to respond_to( :title )
    end

    it "has a title attribute" do
      expect(question).to have_attributes( title: "New Question Title"  )
    end

    it "responds to body attribute" do
      expect(question).to respond_to( :body )
    end
    
    it "has a body attribute" do
      expect(question).to have_attributes( body: "New Question Body"  )
    end

    it "responds to resolved attribute" do
      expect(question).to respond_to( :resolved )
    end
    
    it "has a resolved attribute" do
      expect(question).to have_attributes( resolved: false  )
    end

    it "returns false when unresolved" do
      expect(question.resolved).to be_falsey
    end

    it "returns true when resolved" do
      expect(question2.resolved).to be
    end
  end
end
