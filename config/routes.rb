Rails.application.routes.draw do
  root 'pages#index'
  resources :animegifs
  get 'animegif/search' => 'pages#search'
  get 'about' => 'pages#about'
  get 'contact' => 'pages#contact'
  get 'popular' => 'pages#ratingsort'
  get 'random' => 'pages#random'
  scope :api do
    #Note APIDota = Dota 2 api records
    #     APILOL = LOL 2 API Records (LOL has way too many images)
    scope :dota2 do
      get 'main' => 'pages#dota2main'
      get 'icons' => 'pages#dota2icon'
      get 'icons/all' => 'pages#dota2icon_all'
      get 'popular' => 'pages#dota2_popular'
    end
    scope :lol do
      get 'main' => 'pages#lolmain'
      get 'fanart' => 'pages#lolfanart'
      get 'random' => 'pages#lolrandom'
    end
  end

  scope :projects do
    get 'web' => 'projects#web'
    get 'mobile' => 'projects#mobile'
  end
  get 'projects' => 'projects#index'

end
