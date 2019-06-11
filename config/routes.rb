Rails.application.routes.draw do
  resources :topics
  #instructs Rails to create post routes for creating, updating, viewing, and deleting instances of Post
  resources :posts

  get 'about' => 'welcome#about'
  get 'contact' => 'welcome#contact'
  get 'faq' => 'welcome#faq'

  root 'welcome#index'

end
