class BoardgamesController < ApplicationController

    get '/boardgames' do 
        @boardgames = Boardgame.all 
        erb :'boardgames/index'
    end

    get '/boardgames/new' do 
        if !logged_in?
            flash[:message] = "Please login first!"
            redirect '/login'
        else    
            erb :'boardgames/new'
        end
    end

    post '/boardgames' do 
        boardgame = Boardgame.find_by_name(params[:boardgame][:name])

        if !logged_in?
            flash[:message] = "Plase log in first!"
            redirect '/login'
        elsif params[:boardgame][:name].blank?
            flash[:message] = "Please input a name"
            redirect '/boardgames/new'
        elsif boardgame
            flash[:message] = "This game already exists!"
            redirect '/boardgames/new'
        else
            bg = Boardgame.new(params[:boardgame])
            bg.creator_id = current_user.id
            current_user.boardgames << bg 
            bg.save
            redirect "/boardgames/#{bg.id}"
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

    post '/search' do
        # input = params[:name]
        # words = input.split
        # name = words.map {|w| w.capitalize}.join(" ")
        # bg = Boardgame.find_by(name: name)
        input = params[:name].capitalize
        bg = Boardgame.find_by(name: input)
        if bg 
            redirect "/boardgames/#{bg.id}"
        else
            flash[:message] = "Can't find a boardgame with this name in the database. Create a new one?"
            if logged_in?
                redirect '/boardgames/new'
            else
                redirect '/login'
            end
        end
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
