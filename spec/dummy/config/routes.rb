Rails.application.routes.draw do
  resources :celebrities do
    post 'multiply', on: :collection
  end
end
