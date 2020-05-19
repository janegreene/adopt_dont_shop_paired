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

  def update
    # require "pry"; binding.pry
    pets_approved = params[:pet_ids]
    @app = Application.find(params[:id])
    pets_approved.each do |pet_id|
      pet = Pet.find(pet_id)
      if pet.pet_applications.any? { |app| app.approved == true }
        flash[:notice] = "No more applications can be approved for this pet at this time."
      else
      pet.update(status: "Pending")
      pet_app = pet.pet_applications.find_by(application_id: params[:id])
      pet_app.update(approved: true)
      # PetApplication.find_by(pet_id: pet_id, application_id: params[:id])
      end
    end
    if pets_approved.length > 1
      redirect_to "/pets"
    else
      pet_id = pets_approved.first.to_i
      pet = Pet.find(pet_id)
      redirect_to "/pets/#{pet.id}"
    end
  end

  def unapprove
    pets_approved = params[:pet_ids]
    @app = Application.find(params[:id])
    pet_app = PetApplication.where(application_id: @app.id).first
    # require "pry"; binding.pry
    pet = Pet.where(id: pet_app.pet_id)
    pet_app.update(approved: false)
    pet.update(status: "Adoptable")

    redirect_to "/applications/#{@app.id}"

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
