Rails.application.routes.draw do

  resources :todo_lists do
    resources :todo_items do 
      member do
        patch :complete
      end
    end
  end

  # Defines the root path route ("/")
  root "todo_lists#index"
  
end
