Rails.application.routes.draw do
  ''' Home routes '''

  root to: "home#index"

  # Welcome page
  get "/welcome", to: "welcome#index"

  ''' Users routes '''

  # Sessions
  get "/login", to: "sessions#new", as: "login"
  post "/login", to: "sessions#create", as: "login_create"
  delete "/logout", to: "sessions#destroy", as: "logout"

  # Registration
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"

  # Profile
  get "/profile", to: "users#index", as: "profile"


  ''' Testing routes '''

  # Questions
  get "/questions", to: "questions#index", as: "questions"
  get "/questions/:id", to: "questions#show", as: "question"

  # Answers
  post "/answers", to: "answers#create"

end
