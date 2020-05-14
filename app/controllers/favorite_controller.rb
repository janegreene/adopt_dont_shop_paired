class FavoriteController < ApplicationController
  def update
    pet = Pet.find(params[:pet_id])
    favorite.add_pet(pet.id)
    session[:favorite] = favorite.contents
    quantity = favorite.count_of(pet.id)

   flash[:notice] = "You have favorited #{pet.name}."
   redirect_to "/pets/#{pet.id}"

  end

end
