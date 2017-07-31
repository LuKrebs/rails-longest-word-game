class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all         # GET /restaurants
  end

  def show
  end

  def new
    @user = User.new
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    @user.save

    redirect_to users_path
  end

  def edit
  end

  def update        # PATCH /restaurants/:id
    @user.update(user_params)

    redirect_to users_path
  end

  def destroy
    @user.destroy

    # no need for app/views/restaurants/destroy.html.erb
    redirect_to users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
