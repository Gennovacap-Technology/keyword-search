Rails.application.routes.draw do

  controller :keywords, as: 'keywords' do
    get 'index'
    get 'search'
  end

  root to: "keywords#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
