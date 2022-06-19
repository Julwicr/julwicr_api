Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :longest_words, only: %i[index show create]
    end
  end
end
