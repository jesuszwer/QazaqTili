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
  get "/profile/edit/:id", to: "users#edit", as: "profile_edit"
  patch "/profile", to: "users#update", as: "profile_update"


  ''' Testing routes '''

  # Questions
  get "/questions", to: "questions#index", as: "questions"
  get "/questions/:id", to: "questions#show", as: "question"

  # Answers
  post "/answers", to: "answers#create"

  '''

  допустим есть вопросы в отдельных страницах. пользователь выбирает ответ, и нажимает далее.
  при нажатии на далее, вопрос переходит на следующую страницу с новым вопросом. Между этим
  проиходит обработка ответа на вопорс, в куки сохраняется идентификатор вопроса и если ответ был правильным, то в куки заносится еще один идентификатор "баллов".

  тут есть проблема, как понять какой из аспектов языка у пользователя хромает?

  у вопроса есть тип, можно создать допустим 3-4 типа вопросов, условно громатика, постановка слов,
  чтение, перевод слов и т.д. и создать на каждый из них свой индификатор в сохраняемом куки. И после чего можно узнать какой из аспектов пользователя в языке хромает.

  '''

end