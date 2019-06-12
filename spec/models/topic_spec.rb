require 'rails_helper'

RSpec.describe Topic, type: :model do
  let(:name) {RandomData.random_sentence}
  let(:description) {RandomData.random_paragraph}
  let(:public) {true}
  let(:topic) {Topic.create!(
    name: name,
    description: description, 
    public: public 
    )}
    
    it { is_expected.to have_many(:posts) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:public) }
  
  # # is_at_least not behaving properly
  it { should validate_presence_of(:title).is_at_least(5).on(:create) }
  it { should validate_presence_of(:body).is_at_least(15).on(:create) }


    describe "attributes" do
      it "has name, description, and public attributes" do
        expect(topic).to have_attributes( 
          name: name, 
          description: description,
          public: public
          )  
      end

      it "is public by default" do
        expect(topic.public).to be  
      end
    end
    
end
