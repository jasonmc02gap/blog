include PotatoConfiguration
class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate, only: [:create,:new]
  def index
    @users = db.view User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    @user._attachments = construct_attach unless user_params[:image].blank?

    respond_to do |format|
      if @user.save  
        session[:user_id] = @user.id
        format.html { redirect_to root_url, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      @user.update(user_params) ? format.html { redirect_to @user, notice: 'User was successfully updated.' } : format.html { render :edit }
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
    end
  end

  private
    def set_user
      @user = db.load params[:id]
    end

    def user_params
      params.require(:user).permit(:first_name,:last_name,:email,:password,:password_confirmation,:image)
    end

    def attach_image
      File.read(user_params[:image].tempfile)
    end

    def construct_attach
      {"profile" => {
        'data' => attach_image, 
        'content_type' => user_params[:image].content_type
        }
      }
    end
end
