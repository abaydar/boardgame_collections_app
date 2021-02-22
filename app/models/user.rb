class User < ActiveRecord::Base
    has_secure_password
    has_many :user_boardgames
    has_many :boardgames, through: :user_boardgames

end