class AppsController < ApplicationController

  def new
    @favorites = favorite.favorite_pets
  end

  def create
    @apps = Application.create
      params[:pet_ids].each do |id|
        session[:favorite].delete(id.to_s)
      end
    flash[:notice] = "You have submitted your application to adopt."
    redirect_to "/favorites"
  end

  private

  def app_params
    params.permit(:name, :address, :city, :state, :zip, :description, :phone)
  end

end
