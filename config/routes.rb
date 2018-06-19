Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'top_stories#index'
  resources :top_stories, only: %i[index]
end
