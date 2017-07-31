Rails.application.routes.draw do

  get 'game', to: 'longest#game'

  get 'score', to: 'longest#score'

  root to: 'longest#home'

  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
