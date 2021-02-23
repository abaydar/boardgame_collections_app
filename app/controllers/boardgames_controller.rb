class BoardgamesController < ApplicationController

    get '/boardgames' do 
        @boardgames = Boardgame.all 
        erb :'boardgames/index'
    end

    get '/boardgames/new' do 
        erb :'boardgames/new'
    end

    post '/boardgames' do 
        bg = Boardgame.create(params[:boardgame])
        user = User.find(session[:user_id])
        user.boardgames << bg 
        bg.save
    end



    get '/boardgames/:id' do
        @boardgame = Boardgame.find(params[:id])

        erb :'boardgames/show'
    end

    get '/boardgames/:id/edit' do 
        erb :'boardgames/edit'
    end


end
