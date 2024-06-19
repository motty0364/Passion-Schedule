Rails.application.routes.draw do

  scope module: :public do
    devise_for :users, path: '/', controllers: {
      sessions: 'public/users/sessions',
      registrations: 'public/users/registrations'
    }
    root 'homes#top'
    get 'homes/about' => 'homes#about', as: 'about'
    resources :homes, only: [:edit, :update, :destroy]
    delete 'projects/:id/image' => 'projects#image_destroy', as: 'image_destroy'
    resources :projects, only: [:show, :new, :create, :edit, :update, :destroy] do
      resources :tasks, only: [:show, :create, :edit, :update, :destroy ]
      delete 'tasks/:id/image' => 'tasks#task_image_destroy', as: 'task_image_destroy'
    end
    resource :task_relationships, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
