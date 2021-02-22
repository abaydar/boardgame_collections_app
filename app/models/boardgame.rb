class Boardgame < ActiveRecord::Base
    has_many :user_boardgames
    has_many :users, through: :user_boardgames
end