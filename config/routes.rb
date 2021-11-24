Rails.application.routes.draw do
  root "home#index"

  resources :articles do 
    resources :comments
    resources :article_histories
  end

  resources :orders do
    collection do 
      post :multiple_receipts
    end
  end
end 
