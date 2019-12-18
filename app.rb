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
    Listing.create(owner_id: 002, title: params[:title], address: params[:address], description: params[:description], price: params[:price])
    redirect '/listing/id'

  end

  get '/listing/id' do
    #details of listing
    #book button should redirect to '/listing-id/book'
    erb :'listing/id'
  end

  get '/listing-id/book' do
    #form
    #submit button
    erb :'listing-id/book'
  end

  post '/listing-id/book' do
    #booking details
    redirect '/listing-id/confirmation'
  end

  get '/listing-id/confirmation' do
    #booking details
    #homepage button
    erb :'listing-id/confirmation'
  end

  run! if app_file == $0

end
