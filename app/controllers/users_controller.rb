class UsersController < ApplicationController
  before_action :set_user, only: [:edit,:update, :show]
  before_action :require_admin, only: [:destroy]
  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end
  def new
    @user = User.new
  end

  def show

    @user_articles = @user.articles.paginate(page: params[:page],per_page:  5)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to WEBINTEL #{@user.username}"

      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def edit

  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:danger] = "User and all articles created by user have been deleted."
    redirect_to users_path
  end

  def update

    if @user.update(user_params)
      flash[:success] = "Your account has been updated"
      redirect_to articles_path
    else
      render 'new'
    end
  end
  private
  def user_params
    params.require(:user).permit(:username,:email,:password)
  end
  def set_user
    @user = User.find_by(id: params[:id])
    if @user.nil?
      redirect_to root_path, alert: 'User not found.'
    end
  end

  def require_admin
    if logged_in? && (!current_user || !@user.admin?)
      flash[:danger] = "Only  the correspodent user can perform that action"
    end
  end


end