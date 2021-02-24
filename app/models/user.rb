class User < ActiveRecord::Base
    has_secure_password
    has_many :user_boardgames
    has_many :created_boardgames, :class_name => "Boardgame", :foreign_key => "creator_id"
    has_many :boardgames, through: :user_boardgames

end