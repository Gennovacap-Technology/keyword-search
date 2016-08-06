Rails.application.routes.draw do

  get "homes/index"

  controller :keywords, as: 'keywords', path: 'keywords' do
    get '/', to: "keywords#index"
    post 'search'
  end

  controller :authorizations, as: 'authorizations' do
    get "login"
    get "callback"
    get "logout"
  end

  controller :accounts, as: 'accounts', path: 'accounts' do
    get "/", to: "accounts#index"
    put "select"
  end

  root :to => "homes#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
