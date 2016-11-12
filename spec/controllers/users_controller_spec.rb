require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:valid_attributes) { { :name => 'First Last', :email => 'xyz@email.com', :password => 'password' } }

  let(:valid_session) { { :name => 'First Last', :email => 'xyz@email.com', :password => 'password' } }

  let(:invalid_attributes) { { :name => 'First Last', :email => 'xyz@email.com' } }

  let(:current_user) { FactoryGirl.create(:user, :admin_user) }

  before(:each) do
    sign_in current_user
  end

  describe "GET #index" do
    3.times { FactoryGirl.build(:user) }
    it "assigns all users as @users" do
      get :index
      expect(assigns(:users).map(&:name)).to eq User.all.map(&:name)
    end
  end

  describe "GET #new" do
    it "renders users/new" do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe "GET #edit" do
    let(:user) { FactoryGirl.create(:user) }
    it "renders users/.id/edit" do
      get :edit, :id => user.id
      expect(response).to render_template('edit')
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new User" do
        expect {
          post :create, {:user => valid_attributes}, valid_session
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        post :create, {:user => valid_attributes}, valid_session
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to be_persisted
      end

      it "redirects to the list of users" do
        post :create, {:user => valid_attributes}, valid_session
        expect(response).to redirect_to users_path
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved user as @user" do
        post :create, {:user => invalid_attributes}, valid_session
        expect(assigns(:user)).to be_a_new(User)
      end

      it "re-renders the 'new' template" do
        post :create, {:user => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { :password => 'newpassword' }
      }

      it "updates the requested user" do
        user = User.create! valid_attributes
        put :update, {:id => user.to_param, :user => new_attributes}, valid_session
        user.reload
        expect(assigns(:user)).to eq(user)
      end

      it "assigns the requested user as @user" do
        user = User.create! valid_attributes
        put :update, {:id => user.to_param, :user => valid_attributes}, valid_session
        expect(assigns(:user)).to eq(user)
      end

      it "redirects to the list of users" do
        user = User.create! valid_attributes
        put :update, {:id => user.to_param, :user => valid_attributes}, valid_session
        expect(response).to redirect_to users_path
      end
    end

    context "with invalid params" do
      it "assigns the user as @user" do
        user = User.create! valid_attributes
        put :update, {:id => user.to_param, :user => invalid_attributes}, valid_session
        expect(assigns(:user)).to eq(user)
      end

      # it "re-renders the 'edit' template" do
      #   user = User.create! valid_attributes
      #   put :update, {:id => user.to_param, :user => invalid_attributes}, valid_session
      #   expect(response).to render_template("edit")
      # end
    end
  end
end
