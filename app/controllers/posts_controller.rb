class PostsController < ApplicationController
  before_action :signed_in_user
  before_action :load_posts, only: :create
  before_action :correct_user, only: :destroy

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      current_user.update_attribute(:current_action_id, nil)
      current_user.update_attribute(:action_created_at, nil)
      current_user.update_attribute(:points, (current_user.points+10))
      #flash[:success] = "Post created!"
      redirect_to :controller => :users, :action => :show, :id => current_user.id
    else
      @action = Action.new
      render "users/show"
    end
  end

  def destroy
    @post.destroy
    redirect_to :back
  end
  
  private

    def post_params
      params.require(:post).permit(:content, :image, :action_id)
    end
    
    def correct_user
      if current_user.admin?
        @post = Post.find_by(id: params[:id])
      else
        @post = current_user.posts.find_by(id: params[:id])
      end
      redirect_to root_url if @post.nil?
    end
end