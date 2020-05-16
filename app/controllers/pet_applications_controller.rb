class PetApplicationsController < ApplicationController
  def index
    @pet_apps = PetApplication.all
  end
end
