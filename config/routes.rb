Rails.application.routes.draw do

  get "homes/index"

  controller :keywords, as: 'keywords', path: 'keywords' do
    get 'index'
    post 'search'
  end

  controller :authorizations, as: 'authorizations' do
    get "login"
    get "callback"
    get "logout"
  end

  root :to => "homes#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
