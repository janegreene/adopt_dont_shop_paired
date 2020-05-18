Rails.application.routes.draw do
  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  get '/shelters/:id', to: 'shelters#show'
  post '/shelters', to: 'shelters#create'
  get '/shelters/:id/edit', to: 'shelters#edit'
  put '/shelters/:id', to: 'shelters#update'
  delete '/shelters/:id', to: 'shelters#destroy'

  get '/shelters/:id/review', to: 'reviews#new'
  post '/shelters/:id/review', to: 'reviews#create'
  get '/shelters/:id/:review_id/edit', to: 'reviews#edit'
  patch '/shelters/:id/:review_id', to: 'reviews#update'
  delete '/shelters/:id/:review_id', to: 'reviews#destroy'

  get '/pets', to: 'pets#index'
  get '/pets/:id', to: 'pets#show'
  get '/pets/:id/edit', to: 'pets#edit'
  patch '/pets/:id', to: 'pets#update'
  delete '/pets/:id', to: 'pets#destroy'

  get '/favorites', to: 'favorite#index'
  patch '/favorites/:pet_id', to: 'favorite#update'
  delete '/favorites/:id', to: 'favorite#destroy'
  delete '/favorites', to: 'favorite#destroy_all'
  get '/shelters/:shelter_id/pets', to: 'shelter_pets#index'
  get '/shelters/:shelter_id/pets/new', to: 'pets#new'
  post '/shelters/:shelter_id/pets', to: 'pets#create'

  get '/applications/new', to: 'apps#new'
  get '/applications/:id', to: 'apps#show'
  post '/applications/new', to: 'apps#create'
  patch 'applications/:id/update', to: 'apps#update'
  # patch '/pets/:id/change_status', to: 'pets#change_status'

  get '/pets/:id/applications', to: 'pet_applications#index'
end
