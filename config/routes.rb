Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root "home#index"
  get "about" => "home#about"

  get "register" => "register#index"
  post "register" => "register#register"
  get "register/confirm/:id/:confirmation_token" => "register#confirm", as: "register_confirm"

  get "login" => "login#index"
  post "login" => "login#login"
  post "logout" => "login#logout"

  get "totp_enroll" => "user#enroll_totp"
  post "totp_enroll" => "user#confirm_totp"

  get "totp_verify" => "user#totp_verify"
  post "totp_verify" => "user#verify_totp_code"
end
