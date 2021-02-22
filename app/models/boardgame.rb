class Boardgame < ActiveRecord::Base
    has_many :user_boardgames
    has_many :boardgames, through: :user_boardgames
end