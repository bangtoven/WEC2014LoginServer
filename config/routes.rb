Rails.application.routes.draw do
    post '/signup' => "users#signup"
    post '/login' => "users#login"
    post '/cleardata' => "users#cleardata"

    resources :users
    root "users#new"
end
