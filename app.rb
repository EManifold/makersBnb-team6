require 'sinatra'

class MakersBnb < Sinatra::Base

  get '/' do
    #all listings
    #sign up button
    #add listing
    erb :index
  end

  get '/sign-up' do
    #form
    #submit button
    erb :sign_up
  end

  post '/sign-up' do
    #user details (params)
    #redirect to '/'
  end

  get '/new' do
    #form
    #submit
  end

  post '/new' do
    #listing details (params)
    #redirect to '/listing_id'
  end

  get '/listing-id' do
    #details of listing
    #book button should redirect to '/listing-id/book'
    erb :listing_id
  end

  get '/listing-id/book' do
    #form
    #submit button
  end

  post '/listing-id/book' do
    #booking details
    #redirect to booking confirmation
  end

  get '/listing-id/confirmation' do
    #booking details
    #homepage button
  end

  run! if app_file == $0

end
