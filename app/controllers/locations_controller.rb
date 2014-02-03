class LocationsController < ApplicationController
  before_action :signed_in_user
  before_action :check_empty

  def create
    @added_action = params[:location][:action][:action]
    if Location.find_by(location: params[:location][:location]).nil?
      @location = Location.create!(location: params[:location][:location])
      @action = @location.add_action(@added_action)
      if @action.save
        redirect_to help_path        
      else
        flash[:error] = "Invalid action"
        redirect_to help_path
        #render 'static_pages/help'
      end
    else
      @location = Location.find_by(location: params[:location][:location])
      @action = @location.add_action(@added_action)
      if @action.save
        redirect_to help_path
      else
        flash[:error] = "Invalid action"
        redirect_to help_path
        #render 'static_pages/help'
      end
    end
  end

  private
  
    def check_empty
      if (params[:location][:action][:action].empty? && params[:location][:location].empty?)
        flash[:error] = "All fields required"
        redirect_to help_path
      end
    end

end