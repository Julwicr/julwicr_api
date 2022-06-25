Rails.application.routes.draw do

  resources :api_keys, only: %i[create destroy index]
  namespace :api do
    namespace :v1 do
      get '/longest_words/top', to: 'longest_words#top'
      resources :longest_words, only: %i[index show create new]
    end
  end
end
