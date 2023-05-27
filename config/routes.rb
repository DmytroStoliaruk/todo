Rails.application.routes.draw do

  resources :todo_lists do
    resources :todo_items
  end

  # Defines the root path route ("/")
  root "todo_lists#index"
  
end
