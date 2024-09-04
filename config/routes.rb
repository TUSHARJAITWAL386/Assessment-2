Rails.application.routes.draw do
  resources :users, param: :_username
  post '/auth/login', to: 'authentication#login'
  resources :enrollments, only: [:index, :create, :update, :destroy]
  resources :courses
  get '/student_enrolled_courses', to: 'users#student_enrolled_courses'
end
