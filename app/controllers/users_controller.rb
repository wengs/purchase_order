class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_is_admin

  def index
    @q = User.ransack(params[:q])
    @users = @q.result.page(params[:page]).per(25)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update(user_params)
        format.html {
          flash[:success] = 'User was successfully updated.'
          redirect_to users_path
        }
        format.json { render :edit, status: :created, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html {
          flash[:success] = 'User was successfully created.'
          redirect_to users_path
        }
        format.json { render :edit, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def user
    if params[:user]
      params[:user]
    else
      User.all
    end
  end

  def user_params
    if current_user.admin? && params[:user][:password].empty?
      params.require(:user).permit(
        :name,
        :email,
        :role_id
      )
    else
      params.require(:user).permit(
        :name,
        :email,
        :password,
        :role_id
      )
    end
  end
end
