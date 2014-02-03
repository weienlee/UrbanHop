class ActionsController < ApplicationController
  before_action :signed_in_user

  def destroy
    @action = Action.find_by(id: params[:id])
    @location = Location.find_by(id: @action.location_id)
    @action.destroy
    if Action.find_by(location_id: @location.id).nil?
      @location.destroy
    end
    redirect_to :back
  end
  
  def create
    @action = Action.first(:offset => rand(Action.count))
    current_user.update_attributes(current_action_id: @action.id, action_created_at: Time.now)
    @post = current_user.posts.build(action_id: @action.id)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
  
end