# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'
  get 'termos_e_condicoes', to: 'home#terms_and_conditions', as: :terms_and_conditions

  # Categorias
  get 'categorias', to: 'categories#index', as: :categorias
  get 'categoria/:url', to: 'categories#show', as: :categoria, constraints: { url: /.*/ }

  get 'landing/nova-avaliacao', to: 'landing_pages#index'
  get 'landing/:url', to: 'landing_pages#new'
  get 'landing/nova-avaliacao/obrigado', to: 'landing_pages#thanks'
  get 'errors/not_found', as: :not_found_error
  get 'errors/internal_server_error'

  delete '/logout', to: 'oauth#destroy'
  get '/logout', to: 'oauth#destroy'
  get '/login', to: 'oauth#login'
  get '/auth/:provider/callback', to: 'oauth#callback', as: 'oauth_callback'
  get '/auth/failure', to: 'oauth#failure', as: 'oauth_failure'
  get '/search', to: 'search#index', as: 'search'

  get 'avaliacao/obrigado', to: 'assessments#thanks', as: :thanks_assessments
  match 'avaliacao/:url', to: 'assessments#create', constraints: { url: /.*/ }, as: :create_avaliacao, via: [:post, :patch, :put]
  get 'avaliacao/:url', to: 'assessments#new', constraints: { url: /.*/ }, as: :new_avalicacao

  # Produtos
  get 'produto/:url/obrigado', to:'products#thanks', as: :thanks_products
  get 'produto/checkprod', to: 'products#checkprod', as: 'check_produto'
  get 'produto/:url/editar', to: 'products#edit', as: :edit_products
  get 'produto/novo_produto', to: 'products#new', as: :novo_produto
  get 'produto/entrar_para_cadastrar', to: 'products#login_to_setup', as: :login_to_setup
  get 'produto/:url', to:'products#show', as: :produto, constraints: { url: /.*/ }
  patch '/produto/:id', to: 'products#update'
  put   '/produto/:id', to: 'products#update'
  post  '/produtos', to: 'products#create', as: :produtos

  resources :products, only: [:create, :update] do
    member do
      get :demo
    end
  end

  # Routes for API
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :rankings, only: [ :index, :show ]
    end
  end

  get '/sitemap', to: 'sitemap#index', as: :sitemap

  mount_roboto

  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all
end
