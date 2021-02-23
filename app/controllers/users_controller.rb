class UsersController < ApplicationController

    get '/login' do 
        erb :'users/login'
    end

    post '/login' do 
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect to "/users/#{@user.username}"
        else
            redirect '/login'
        end
        
    end

    get '/signup' do 
        erb :'users/new'
    end

    post '/signup' do 
        user = User.find_by(username: params[:username])
        user_email = User.find_by(email: params[:email])

        if params[:name].blank? || params[:username].blank? || params[:email].blank? || params[:password].blank?
            flash[:message] = "Please fill out all fields"
            redirect '/signup'
        elsif user || user_email
            flash[:message] = "This account already exists!"
            redirect '/signup'
        else
            new_user = User.new(name: params[:name], username: params[:username], email: params[:email], password: params[:password])
            new_user.save
            redirect '/login'
        end
    end

    get '/users/:username' do 
        if !logged_in?
            redirect '/login'
        end

        
        @user = User.find_by(username: params[:username])
        if !@user.nil? && @user == current_user
            erb :'users/show'
        else
            redirect '/login'
        end

    end

    get '/logout' do 
        logout 
        redirect '/'
    end




end
