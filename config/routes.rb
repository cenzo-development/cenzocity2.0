Rails.application.routes.draw do
  get 'passcode/enter' => 'passcode#enter', as: 'passcode'
  post 'passcode/enter' => 'passcode#submit', as: 'submit_code'
  get 'dashboard/index' => 'dashboard#index'
  delete '/logout' => 'sessions#destroy'

  root to: 'dashboard#index'




  resources :sessions, only: [:new, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
