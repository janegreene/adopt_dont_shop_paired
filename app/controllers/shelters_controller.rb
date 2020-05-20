class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def new
  end

  def create
    shelter = Shelter.new(shelter_params)
    if shelter.save
        redirect_to '/shelters'
    else
        flash.now[:notice] = shelter.errors.full_messages.join(". ").to_s
        render :new
    end
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    @shelter = Shelter.find(params[:id])

   if  @shelter.update(shelter_params)
    redirect_to "/shelters/#{@shelter.id}"
   else
    flash[:notice] = @shelter.errors.full_messages.join(". ").to_s
    redirect_to "/shelters/#{@shelter.id}/edit"
   end

  end

  def destroy
    shelter = Shelter.find(params[:id])
    if shelter.pets.where(status: :Pending).exists?
      flash[:notice] = "Pet pending adoption, shelter can not be deleted."
    else
      Shelter.destroy(params[:id])
    end
    redirect_to "/shelters"
  end

  private

  def shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
