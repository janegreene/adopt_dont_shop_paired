class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def new
    @shelter_pet = Shelter.find(params[:shelter_id])
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    pet = shelter.pets.new(pet_params)

    if pet.save
        pet.status = "Adoptable"
        redirect_to "/shelters/#{pet.shelter_id}/pets"
    else
      flash[:notice] = pet.errors.full_messages.join(". ").to_s
        redirect_to "/shelters/#{pet.shelter_id}/pets/new"
    end
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    @pet = Pet.find(params[:id])
    if @pet.update(pet_params)
      redirect_to "/pets/#{@pet.id}"
    else
      flash[:notice] = @pet.errors.full_messages.join(". ").to_s
      redirect_to "/pets/#{@pet.id}" #this is not addressed in the story so it may need revisiting
    end
  end

  def destroy
    Pet.destroy(params[:id])
    redirect_to "/pets"
  end

  def change_status
    @pet = Pet.find(params[:id])

    if @pet.status == "Pending"
      @pet.update(status: "Adoptable")
    else
      @pet.update(status: "Pending")
    end
    # change_app_status
    redirect_to "/pets/#{@pet.id}"
  end

  #  def change_app_status
  #  self.pet_applications.update(approce)
  # end



  private

  def pet_params
    params.permit(:name, :image, :age, :description, :sex, :status)
  end
end
