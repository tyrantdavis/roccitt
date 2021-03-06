require 'rails_helper'

RSpec.describe Topic, type: :model do
  let(:public) {true}
  let(:topic) { create(:topic) }

    
    it { is_expected.to have_many(:posts) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:public) }
  
  # # is_at_least not behaving properly
  it { should validate_length_of(:name).is_at_least(5).on(:create) }
  it { should validate_length_of(:description).is_at_least(15).on(:create) }


    describe "attributes" do
      it "has name, description, and public attributes" do
        expect(topic).to have_attributes( 
          name: topic.name, 
          description: topic.description,
          public: public
          )  
      end

      it "is public by default" do
        expect(topic.public).to be  
      end
    end
    
end
