Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :events do
    resources :comments
  end

  namespace :api, :defaults => { :format => :json } do
    namespace :v1 do
      get "/events" => "events#index", :as => :events
      get "/events/:event_id" => "events#show", :as => :event
      get "/comments/:comment_id" => "comments#show", :as => :comment
      post "/comments" => "comments#create", :as => :create_comments
      delete "/comments/:comment_id" => "comments#destroy", :as => :delete_comment
      post "/signup" => "auth#signup"
      post "/login" => "auth#login"
      post "/logout" => "auth#logout"
    end
  end
  root "events#index"
end
