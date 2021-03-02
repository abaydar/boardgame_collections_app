class UsersController < ApplicationController

    get '/users' do 
        @users = User.all
        erb :'users/index'
    end

    get '/login' do 
        if !logged_in?
            erb :'users/login'
        else
            redirect "/users/#{current_user.id}"
        end
    end

    post '/login' do 
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect to "/users/#{@user.id}"
        else
            flash[:message] = "There was an error logging you in.  Please make sure your username and password are correct."
            redirect '/login'
        end
        
    end

    get '/signup' do 
        if !logged_in?
            erb :'users/new'
        else
            redirect "/users/#{current_user.id}"
        end
    end
    
    get '/users/:id/delete' do
        get_user
        erb :'users/delete'
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
    
    
    get '/users/:id' do 
        get_user
        if !logged_in?
            redirect '/login'
        else
           erb :'users/show'
        end             
    end
    
    get '/logout' do 
        logout 
        redirect '/'
    end
    
    get '/users/:id/edit' do 
        get_user
        
        if logged_in?
            redirect_if_not_authorized
            erb :'users/edit'
        else
            redirect '/login'
        end
    end
    

    patch '/users/:id' do 
        get_user
  
        redirect_if_not_authorized

        params[:user][:boardgame_ids].each do |id|
            if !@user.boardgames.include?(Boardgame.find_by(id: id))
                @user.boardgames << Boardgame.find_by(id: id)
            end  
        end

        redirect "/users/#{@user.id}"
    end

    post '/users/:id/boardgames/:bg_id' do 
        get_user
        redirect_if_not_authorized
        bg = Boardgame.find_by(id: params[:bg_id])
        @user.boardgames.delete(bg)
        flash[:message] = "#{bg.name} has been removed from your collection"
        redirect "/users/#{@user.id}"
    end


    delete '/users/:id' do
        get_user
        redirect_if_not_authorized
        @user.delete
        redirect '/'
    end

private

    def get_user
        @user = User.find_by(id: params[:id])
    end

    def redirect_if_not_authorized
        if @user.id != current_user.id 
            flash[:message] = "You can't edit someone else's collection"
            redirect "/users/#{@user.id}"
        end
    end

    def redirect_to_login
        if !logged_in?
            redirect '/login'
        end
    end

end
