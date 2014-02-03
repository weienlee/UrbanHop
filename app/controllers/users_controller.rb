class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :show, :index, :delete, :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  before_action :load_posts,     only: :show
  
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page], per_page: 10)
    @action = Action.new
    if !current_user.current_action_id.nil?
      if 86400 - ((Time.now - current_user.action_created_at)/1.second).round < 0
        current_user.update_attribute(:current_action_id, nil)
        current_user.update_attribute(:action_created_at, nil)
      end
    end
  end

  def index
    require 'will_paginate/array'
    @users = User.search(params[:search])
    @users = @users.paginate(page: params[:page])
    @search = true
    if params[:search].nil?
      @search = false
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      #flash[:success] = "Welcome to UrbanHop!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    # unnecessary b/c of before_action call to correct_user
    # @user = User.find(params[:id])
  end

  def update
    # unnecessary b/c of before_action call to correct_user
    #@user = User.find(params[:id])
    
    if @user.authenticate(params[:current_password]) && @user.update_attributes(user_params)
      # Handle a successful update.
      # flash[:success] = "Profile updated"
      redirect_to @user
    else
      if !@user.authenticate(params[:current_password])
        flash.now[:error] = "Invalid password"
      end
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email,
      :password, :password_confirmation, :about, :avatar)
    end
    
    # Before filters

    # signed_in_user moved to sessions_helper

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    
end
