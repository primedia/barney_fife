BarneyFife::Application.routes.draw do

  mount Ops.new, at: '/ops'

  if Rails.configuration.worker
    root 'workers#index'
    resources :workers, only: [:index]
  else
    root 'repositories#index'

    resource :webhook, only: [:create]
    resources :repositories
  end
end
