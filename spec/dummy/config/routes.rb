Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :celebrities do
    post 'multiply' => 'celebrities#multiply', on: :collection
  end
end
