DataEngineering::Application.routes.draw do

  root 'documents#new'

  get 'documents', to: 'documents#new'
  resources :documents

end
