class AppsController < ApplicationController

  def new
    @favorites = favorite.favorite_pets
  end

  def index
    @applications = Application.all
    # require "pry"; binding.pry
  end

  def create
    application = Application.new(app_params)

    if application.save
      flash[:notice] = "You have submitted your application to adopt."
      redirect_to "/favorites"

      params[:pet_ids].each do |id|
        @pet_apps = PetApplication.create(pet_id: id, application_id: application.id)
        session[:favorite].delete(id.to_s)
      end
    
    else
      flash.now[:notice] = "Application not submitted: Required information missing."
      render :new
    end
  end

  def show
    @app = Application.find(params[:id])
  end

  # def change_status
  #   @app = Application.find(params[:id])
  #   binding.pry
  # end
 
  

  private

  def app_params
    params.permit(:name, :address, :city, :state, :zip, :description, :phone)
  end

end
