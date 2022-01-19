Rails.application.routes.draw do
  resources :deliveries
  root 'deliveries#new'
end
