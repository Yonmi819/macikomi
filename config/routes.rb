Rails.application.routes.draw do
  
 root to: 'homes#top'
  
 devise_for :users,skip: [:passwords], controllers: {
  registrations: "user/registrations",
  sessions: 'user/sessions'
}
 devise_for :admins, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  
 devise_scope :user do
  post 'user/guest_sign_in', to: 'user/sessions#guest_sign_in'
  end

 namespace :user do
  root to: 'homes#top'
  get "/information" => "homes#about" , as: "about"
  get '/my_page' => "residents#show"
  get '/residents/unsubscribe' => "residents#unsubscribe", as: "unsubscribe"
  patch '/residents/withdrawal' => 'residents#withdrawal', as: 'withdrawal'
  resources :residents, only: [:show, :edit, :update]
  resources :notifications, only: [:index]
  delete "/notifications/destroy_all" => "notifications#destroy_all"
  resources :posts, only: [:new, :create, :index, :show, :destroy] do
   collection do
    get 'search'
   end
  resource  :checks, only: [:create, :destroy]
  resources :post_comments, only: [:create, :destroy]
  end
 end
  
 namespace :admin do
  root to: 'homes#top'
  get '/residents/form' => "residents#form"
  post '/residents/send_mail' => "residents#send_mail"
  resources :events, only: [:new, :create, :update, :destroy]
  resources :residents, only: [:index, :show, :edit, :update, :destro]
 end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
