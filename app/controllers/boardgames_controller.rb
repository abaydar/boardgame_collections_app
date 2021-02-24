class BoardgamesController < ApplicationController

    get '/boardgames' do 
        @boardgames = Boardgame.all 
        erb :'boardgames/index'
    end

    get '/boardgames/new' do 
        if !logged_in?
            redirect '/login'
        else    
            erb :'boardgames/new'
        end
    end

    post '/boardgames' do 
        bg = Boardgame.new(params[:boardgame])
        user = User.find(session[:user_id])
        bg.creator_id = user.id
        user.boardgames << bg 
        bg.save
        redirect "/boardgames/#{bg.id}"
    end

    get '/boardgames/:id' do
        @boardgame = Boardgame.find(params[:id])

        erb :'boardgames/show'
    end

    get '/boardgames/:id/edit' do 
        if !logged_in?
            redirect '/login'
        else
            erb :'boardgames/edit'
        end
    end


end
