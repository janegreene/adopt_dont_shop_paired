class FavoriteController < ApplicationController
  def index
    @favorites = favorite.favorite_pets
  end

  def update
    pet = Pet.find(params[:pet_id])
    favorite.add_pet?(pet.id)
    session[:favorite] = favorite.contents
    quantity = favorite.count_of(pet.id)

   flash[:notice] = "You have favorited #{pet.name}."
   redirect_to "/pets/#{pet.id}"
  end

  def destroy
    pet = Pet.find(params[:id])
    favorite.delete(pet.id.to_s)
   if params[:page] == "favorites"
      redirect_to '/favorites'
    elsif params[:page] == "show"
      flash[:notice] = "You have removed #{pet.name} from Favorite Pets."
      redirect_to "/pets/#{pet.id}"
    end
  end

  def destroy_all
    reset_session
    redirect_to '/favorites'
  end
end


