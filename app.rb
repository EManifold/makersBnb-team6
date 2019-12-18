require 'sinatra'
require './lib/listing'
require './lib/user'

class MakersBnb < Sinatra::Base
  enable :sessions

  get '/' do
    @user = User.find(session[:user_id])
    #all listings
    #sign up button
    #add listing
    erb :index
  end

  get '/login/new'

    erb: :'/login/new'
  end

  post '/login' do

    
    redirect '/'
  end

  post '/login/destroy' do

  end

  get '/listings' do
    @listings = Listing.all
    erb :listings
  end

  get '/sign-up' do
    erb :sign_up
  end

  post '/sign-up' do
    user = User.create(email: params[:email], password: params[:password], name: params[:name], username: params[:username])
    session[:user_id] = user.id.to_i
    redirect '/'
  end

  get '/listing/new' do
    #form
    #submit
    erb :'listing/new'
  end

  post '/listing/new' do
    #listing details (params)
    listing = Listing.create(owner_id: 002, title: params[:title], address: params[:address], description: params[:description], price: params[:price])
    $listing = listing
    redirect '/listing/id'

  end

  get '/listing/search' do
    #Search page, allows user to call on find method
    erb :'listing/search'
  end

  post '/listing/go' do
    redirect '/listings'
  end

  get '/listing/:id' do
    #details of listing
    #book button should redirect to '/listing-id/book'
    @listing = Listing.find_by_id(params[:id])
    erb :'listing/id'
  end

  get '/book/:id' do
    #form
    #submit button
    @listing = Listing.find_by_id(params[:id])
    erb :'listing-id/book'
  end

  post '/book/:id' do
    #booking details
    @listing = Listing.find_by_id(params[:id])
    redirect '/:id/confirmation'
  end

  get '/:id/confirmation' do
    #booking details
    #homepage button
    @listing = Listing.find_by_id(params[:id])
    erb :'listing-id/confirmation'
  end

  run! if app_file == $0

end
