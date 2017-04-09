Rails.application.routes.draw do
  resources :doctors
  devise_for :users

  get 'home/index'
  get 'welcome/about'

  #signed in user doctor is brought to doctor/user profile or if new to add new
  get '/signedinuserdoctor' => 'doctors#signedinuserdoctor'

  # create a nested resource (sub resource) for appointments in patients
  resources :patients do
    # Exclude show and index from appointments
    resources :appointments, except: [:show, :index]
  end

  # specify root
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
