Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get '/longest_words/top', to: 'longest_words#top'
      resources :longest_words, only: %i[index show create new]
    end
  end
end
