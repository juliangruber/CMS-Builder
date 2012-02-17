require 'bowtie'

Cms::Application.routes.draw do
	namespace :structure do
		resources :content_types
		resources :pages
		resources :contents
	end
	resources :posts
  match '/', :controller => :posts, :action => :index
  BOWTIE_AUTH = {:user => 'admin', :pass => '12345'}
  mount Bowtie::Admin, :at => '/admin'
end
