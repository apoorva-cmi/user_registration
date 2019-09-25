require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = FactoryBot.build(:user)
  end

  specify { expect(@user).to be_valid }

  describe 'email' do
    it 'should be present' do
    	@user.save
     	expect(@user.valid?).to be_truthy
    end

    it 'should be unique' do
    	@user.save
     	email = @user.email
     	user2 = FactoryBot.build(:user, email: email)
     	expect(user2.valid?).to be_falsey
     	expect(user2.errors.messages[:email].include?("has already been taken")).to be_truthy
    end

    it 'should be of proper format' do
    	@user.email = 'abc'
    	expect(@user.valid?).to be_falsey
    	expect(@user.errors.messages[:email].include?("Only valid emails allowed")).to be_truthy
    end
  end

  describe 'password_digest' do
  	it 'password should be present and match password confirmation' do
  		@user.password = "11111111"
  		@user.password_confirmation = "22222222"
  		expect(@user.valid?).to be_falsey
  		expect(@user.errors.messages[:password_confirmation].include?("doesn't match Password")).to be_truthy
  	end

  	it 'password should be minimum 8 characters' do
  		@user.password = "111111"
  		expect(@user.valid?).to be_falsey
  		expect(@user.errors.messages[:password].include?("is too short (minimum is 8 characters)")).to be_truthy
  	end
  end

  describe 'username' do
  	it 'should be minimum 5 characters on update' do
  		@user.save

  		@user.username = "abc"
  		expect(@user.valid?).to be_falsey
  		expect(@user.errors.messages[:username].include?("is too short (minimum is 5 characters)")).to be_truthy
  	end
  end
end
