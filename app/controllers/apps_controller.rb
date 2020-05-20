class AppsController < ApplicationController

  def new
    @favorites = favorite.favorite_pets
  end

  # def index
  #   @applications = Application.all
  # end

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
    @app = Application.find(params[:id])
    pet = Pet.find(params[:pet_id])
    pet_app = PetApplication.find_by(pet_id: params[:pet_id], application_id: params[:id])
  
    # if pet.pet_applications.any? { |app| app.approved == true }
    #   flash[:notice] = "No more applications can be approved for this pet at this time."
    #   redirect_to "/applications/#{@app.id}"
    # else
      pet.update(status: "Pending")
      pet_app = pet.pet_applications.find_by(application_id: params[:id])
      pet_app.update(approved: true)
      redirect_to "/pets/#{pet.id}"
    end
  # end

  def unapprove
    @app = Application.find(params[:id])
    pet = Pet.find(params[:pet_id])
    pet_app = PetApplication.find_by(pet_id: params[:pet_id], application_id: params[:id])
    pet_app.update(approved: false)
    pet.update(status: "Adoptable")
    redirect_to "/applications/#{@app.id}"
  end

  private

  def app_params
    params.permit(:name, :address, :city, :state, :zip, :description, :phone)
  end

end
