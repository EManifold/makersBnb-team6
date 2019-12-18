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
    listing = Listing.create(owner_id: 002, title: params[:title], address: params[:address], description: params[:description], price: params[:price])
    $listing = listing
    redirect '/listing/id'

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
