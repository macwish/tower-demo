Rails.application.routes.draw do

  # team
  resources :teams, only: [:show] do 
    collection do 
      get 'list'
    end
  end
  
  # project
  resources :projects, only: [:show] do 
    collection do 
      get 'list'
    end 
  end 

  namespace :project do
    resources :todo_lists, only: [:show]
    resources :todos, except: [:new]
  end

  # users (show-only)
  resources :users, only: [:show] do 
    collection do 
      get 'profile'
    end
  end
  
  # comments (show and create)
  resources :comments, only: [:show, :create]

  # events (list-only)
  resources :events, only: [:index]

  # 
  root 'events#index'
  
end
