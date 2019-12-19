require 'sinatra'
require './lib/listing'
require './lib/user'
require './lib/booking'

class MakersBnb < Sinatra::Base
  enable :sessions

  get '/' do
    @user = User.find(session[:user_id])
    session[:search?] = false #Not searching by default
    erb :index, { :layout => :layout }

  end

  get '/login/new' do
    @user = User.find(session[:user_id])
    erb :'/login/new'
  end


  post '/login' do
    user = User.login(email: params[:email], password: params[:password])
    @user = User.find(session[:user_id])
    if user
      session[:user_id] = user.id
      redirect '/'
    else
      redirect '/login/new'
    end
  end

  get '/login/destroy' do
    @user = User.find(session[:user_id])
    session.clear
    redirect '/'
  end

  get '/listings' do
    @user = User.find(session[:user_id])
    if session[:search?] == true
      @listings = Listing.search(session[:keyword])
    else
      @listings = Listing.all
    end
    session[:search?] = false #Variable already assigned, can reset boolean
    erb :listings
  end

  get '/sign-up' do
    @user = User.find(session[:user_id])
    erb :sign_up
  end

  post '/sign-up' do
    @user = User.find(session[:user_id])
    user = User.create(email: params[:email], password: params[:password], name: params[:name], username: params[:username])
    session[:user_id] = user.id.to_i
    redirect '/'
  end

  get '/listing/new' do
    @user = User.find(session[:user_id])
    #form
    #submit
    erb :'listing/new'
  end

  post '/listing/new' do
    @user = User.find(session[:user_id])
    #listing details (params)
    @listing = Listing.create(owner_id: session[:user_id], title: params[:title], address: params[:address], description: params[:description], price: params[:price])
    redirect '/listings'
  end

  post '/listing/go' do
    @user = User.find(session[:user_id])
    session[:search?] = true #Activate search
    session[:keyword] = params['keyword']
    redirect '/listings'
  end

  get '/listing/:id' do
    @user = User.find(session[:user_id])
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
    @user = User.find(session[:user_id])
    @listing = Listing.find_by_id(params[:id])
    session[:listing_id] = @listing.id
    @booking = Booking.create(listing_id: session[:listing_id], user_id: session[:user_id], start_date: params[:StartDate], end_date: params[:EndDate], no_of_people: params[:NumberOfPeople], total_price: Booking.price_check(params[:StartDate], params[:EndDate], params[:NumberOfPeople], @listing.price))
    session[:booking_id] = @booking.id
    redirect "/confirmation/#{@listing.id}"
  end

  get '/confirmation/:id' do
    #booking details
    #homepage button
    @listing = Listing.find_by_id(params[:id])
    @user = User.find(session[:user_id])
    @booking = Booking.find_by_id(session[:booking_id])
    erb :'listing-id/confirmation'
  end

  run! if app_file == $0

end
