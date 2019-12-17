require 'sinatra'
require './lib/listing'

class MakersBnb < Sinatra::Base

  get '/' do
    #all listings
    #sign up button
    #add listing
    erb :index
  end

  get '/listings' do
    @listings = Listing.all
    erb :listings
  end

  get '/sign-up' do
    #form
    #submit button
    erb :sign_up
  end

  post '/sign-up' do
    #user details (params)
    #redirect to '/'
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
