Rails.application.routes.draw do

  resources :milestones
  resources :substrates
  resources :sides
  resources :regions
  devise_for :users, :path_prefix => 'd'
  resources :users
  resources :graphics
  resources :pos do
    resources :graphics, only: [:new]
    get 'quote_download' => 'file_downloads#get_quote'
    get 'purchase_order_download' => 'file_downloads#get_purchase_order'
    get 'invoice_download' => 'file_downloads#get_invoice'
  end
  resources :activities
  resources :roles
  resources :io_links, only: [:index]
  resources :po_imports, only: [:new, :create]
  resources :graphic_imports, only: [:new, :create]

  root to: "pos#index"

  get 'activity_feed/timeline'

  # the rest goes to root
  get '*path' => redirect('/')
end
