Rails.application.routes.draw do
  root "home#show"

  get "health", to: "health#show"
  post "pulse", to: "pulses#create"

  # Framework-level boot check. `/health` above is the app-level JSON check.
  get "up" => "rails/health#show", as: :rails_health_check
end
