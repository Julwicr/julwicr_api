Rails.application.routes.draw do
  resources :longest_words, only: %i[index show create]

end
