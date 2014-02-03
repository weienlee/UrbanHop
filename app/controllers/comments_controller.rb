class CommentsController < ApplicationController
	before_action :signed_in_user
	def create
		@post = Post.find(params["comment"]["post_id"])
		@comment = Comment.new(comment_params)
		if @comment.save
			flash[:success] = "Comment created!"
			redirect_to :controller => :users, :action => :show, :id => @post.user_id
		else
			render "users/show"
		end
	end

	private
    	def comment_params
      		params.require(:comment).permit(:content, :post_id, :user_id)
    	end
end
