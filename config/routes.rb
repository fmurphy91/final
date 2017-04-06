Rails.application.routes.draw do

  resources :doctors
  devise_for :users
  get 'home/index'


  get 'welcome/about'
  get '/signedinuserdoctor' => 'doctors#signedinuserdoctor'
  resources :patients
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
