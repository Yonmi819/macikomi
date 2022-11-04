Rails.application.routes.draw do
  
  
 root to: 'homes#top'
  devise_scope :user do
    post 'user/guest_sign_in', to: 'user/sessions#guest_sign_in'
  end

  
  devise_for :users,skip: [:passwords], controllers: {
  registrations: "user/registrations",
  sessions: 'user/sessions'
}
  devise_for :admins, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  
  
   namespace :user do
    root to: 'homes#top'
    get "/event" => "homes#about" , as: "event"
    get "/section" => "homes#section" , as: "saigai"
  end
  
  namespace :admin do
    resources :events, only: [:new, :create]
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
