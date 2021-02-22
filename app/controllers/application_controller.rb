require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV.fetch('SESSION_SECRET'){SecureRandom.hex(64)}
  end

  get "/" do
    erb :index
  end

  helpers do 

    def current_user 
      User.find(session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end

    def login(username, password)
      user = User.find_by(username: username)
      if user && user.authenticate(password)
        session[:username] = user.username
        redirect '/boardgames'
      else
        redirect '/login'
      end
    end

    def logout
      session.clear
    end
  end

end
