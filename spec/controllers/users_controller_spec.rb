require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:valid_attributes) {
    { email: "john_smith@example.com", password: "11111111", password_confirmation: "11111111", username: "abcde"}
  }

  let(:invalid_attributes) {
    {email: "john_smith@example.com"}
  }

  before(:each) do
    @user = FactoryBot.create(:user)
  end

  after(:each) do
    User.delete_all
  end
  
  let(:valid_session) { { user_id: @user.id } }

  describe "GET #index" do
    it "returns a success response" do
      User.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      user = User.create! valid_attributes
      get :show, params: {id: user.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      user = User.create! valid_attributes
      get :edit, params: {id: user.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new User" do
        expect {
          post :create, params: {user: valid_attributes}, session: valid_session
        }.to change(User, :count).by(1)
      end

      it "redirects to the created user" do
        post :create, params: {user: valid_attributes}, session: valid_session
        expect(response).to redirect_to(User.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {user: invalid_attributes}, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH #update" do
    context "with valid params" do
      let(:new_attributes) {
        { email: "john_smith2@example.com" }
      }

      it "updates the requested user" do
        user = User.create! valid_attributes
        patch :update, params: {id: user.to_param, user: new_attributes}, session: valid_session
        user.reload
        expect(response).to be_successful
      end

      it "redirects to the user" do
        user = User.create! valid_attributes
        patch :update, params: {id: user.to_param, user: valid_attributes}, session: valid_session
        expect(response).to redirect_to(user)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        user = User.create! valid_attributes
        patch :update, params: {id: user.to_param, user: invalid_attributes}, session: valid_session
        expect(response).to be_successful
      end
    end 
  end

  describe "DELETE #destroy" do
    it "destroys the requested user" do
      user = User.create! valid_attributes
      expect {
        delete :destroy, params: {id: user.to_param}, session: valid_session
      }.to change(User, :count).by(-1)
    end

    it "redirects to the users list" do
      user = User.create! valid_attributes
      delete :destroy, params: {id: user.to_param}, session: valid_session
      expect(response).to redirect_to(users_url)
    end
  end

end
