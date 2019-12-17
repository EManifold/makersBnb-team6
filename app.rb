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
    redirect :index
  end

  get '/new' do
    #form
    #submit
    erb :new
  end

  post '/new' do
    #listing details (params)
    redirect  :listing_id

  end

  get '/listing-id' do
    #details of listing
    #book button should redirect to '/listing-id/book'
    erb :listing_id
  end

  get '/listing-id/book' do
    #form
    #submit button
    erb :listing_id_book
  end

  post '/listing-id/book' do
    #booking details
    redirect :listing_id_confirmation
  end

  get '/listing-id/confirmation' do
    #booking details
    #homepage button
    erb :lisitng_id_confirmation
  end

  run! if app_file == $0

end
