class LikesController < ApplicationController
  before_action :signed_in_user

  def create
    @post = Post.find(params[:like][:post_id])
    @user = @post.user    
    if current_user.like!(@post)
      new_user_points = @user.points + 1
      new_post_points = @post.points + 1
      @user.update_attribute(:points, new_user_points)
      @post.update_attribute(:points, new_post_points)  
    end
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @post = Post.find(Like.find(params[:id]).post_id)
    @user = @post.user
    if current_user.unlike!(@post)
      new_user_points = @user.points - 1
      new_post_points = @post.points - 1
      @user.update_attribute(:points, new_user_points)
      @post.update_attribute(:points, new_post_points)  
    end
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end