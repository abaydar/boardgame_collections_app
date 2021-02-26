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
        if logged_in?
            bg = Boardgame.new(params[:boardgame])
            bg.creator_id = current_user.id
            current_user.boardgames << bg 
            bg.save
            redirect "/boardgames/#{bg.id}"
        else 
            redirect '/login'
        end
    end

    get '/boardgames/:id' do
        get_boardgame

        erb :'boardgames/show'
    end

    get '/boardgames/:id/edit' do 
       get_boardgame
       redirect_if_not_authorized
       erb :'/boardgames/edit'
    end

    patch '/boardgames/:id' do 
        get_boardgame
        redirect_if_not_authorized
        @boardgame.update(params[:boardgame])
        redirect "/boardgames/#{@boardgame.id}"    
    end

    delete '/boardgames/:id' do
        get_boardgame
        redirect_if_not_authorized
        @boardgame.delete
        redirect '/boardgames'
    end



private 

    def get_boardgame
        @boardgame = Boardgame.find_by(id: params[:id])
    end

    def redirect_if_not_authorized
        if @boardgame.creator_id != current_user.id 
            flash[:message] = "You can't edit a boardgame you haven't created"
            redirect '/boardgames'
        end
    end



end
