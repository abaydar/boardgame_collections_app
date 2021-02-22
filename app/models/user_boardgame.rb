class UserBoardgame < ActiveRecord::Base
    belongs_to :user
    belongs_to :boardgame
end