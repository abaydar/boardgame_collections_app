class UsersController < ApplicationController

    get '/login' do 
        erb :'users/login'
    end

    post '/login' do 
        login(params[:username], params[:password])
        redirect '/boardgames'
    end

    get '/signup' do 
        erb :'users/new'
    end

    post '/signup' do 
        user = User.new(name: params[:name], username: params[:username], email: params[:email], password: params[:password])
        if user.save
            redirect '/login'
        else
            erb :'users/new'
        end
    end

    get '/users/:id' do 
        if !logged_in?
            redirect '/login'
        end

        user = User.find(params[:id])
        if !user.nil? && user == current_user
            erb :'users/show'
        else
            redirect '/login'
        end
    end

    get '/logout' do 
        logout 
    end



end
