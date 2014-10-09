Rails.application.routes.draw do
    post '/signup' => "users#signup"
    post '/login' => "users#login"
    post '/cleardata' => "users#cleardata"
    root "users#index"
end
