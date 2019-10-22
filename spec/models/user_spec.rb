require 'rails_helper'

RSpec.describe User, type: :model do
   let(:user) { User.create!(name: "Roccitt User", email: "user@roccitt.com", password: "password") }

  it { is_expected.to have_many(:posts) }
  it { is_expected.to have_many(:comments) }
  it { is_expected.to have_many(:votes) }
     it { is_expected.to have_many(:favorites) }

   # VALID USER
   # Shoulda tests for name
   it { is_expected.to validate_presence_of(:name) }
   it { is_expected.to validate_length_of(:name).is_at_least(1) }
 
   # Shoulda tests for email
   it { is_expected.to validate_presence_of(:email) }
   it { is_expected.to validate_uniqueness_of(:email) }
   it { is_expected.to validate_length_of(:email).is_at_least(3) }
   it { is_expected.to allow_value("user@roccitt.com").for(:email) }
 
   # Shoulda tests for password
   it { is_expected.to validate_presence_of(:password) }
   it { is_expected.to have_secure_password }
   it { is_expected.to validate_length_of(:password).is_at_least(6) }
 
   describe "attributes" do
     it "should have name and email attributes" do
       expect(user).to have_attributes(name: "Roccitt User", email: "user@roccitt.com")
     end

     it "formats the user's email" do
       user.email = "User@Roccitt.COM"
       user.save
       expect(user.email).to eq "user@roccitt.com"  
     end
     
     
     it "should format the user's name" do
       user.name = "roccitt user"
       user.save
       expect(user.name).to eq "Roccitt User"  
     end

     it "responds to role" do
       expect(user).to respond_to(:role)
     end
 

     it "responds to admin?" do
       expect(user).to respond_to(:admin?)
     end
 

     it "responds to member?" do
       expect(user).to respond_to(:member?)
     end
   end
   
   describe "roles" do

     it "is member by default" do
       expect(user.role).to eql("member")
     end
 

     context "member user" do
       it "returns true for #member?" do
         expect(user.member?).to be_truthy
       end
 
       it "returns false for #admin?" do
         expect(user.admin?).to be_falsey
       end
     end
 

     context "admin user" do
       before do
         user.admin!
       end
 
       it "returns false for #member?" do
         expect(user.member?).to be_falsey
       end
 
       it "returns true for #admin?" do
         expect(user.admin?).to be_truthy
       end
     end
   end
   
   # INVALID USER
   describe "invalid user" do
     let(:user_with_invalid_name) { User.new(name: "", email: "user@roccitt.com") }
     let(:user_with_invalid_email) { User.new(name: "Roccitt User", email: "") }
     let(:user_with_invalid_email_format) { User.new(name: "Roccitt User", email: "user.roccit.com ") }
 
     it "should be an invalid user due to blank name" do
       expect(user_with_invalid_name).to_not be_valid
     end
 
     it "should be an invalid user due to blank email" do
       expect(user_with_invalid_email).to_not be_valid
     end

     it "should be an invalid user due to incorrect email format" do
       expect(user_with_invalid_email_format).to_not be_valid  
     end
   end
   
end
