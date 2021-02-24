class Boardgame < ActiveRecord::Base
    has_many :user_boardgames
    has_many :users, through: :user_boardgames
    belongs_to :creator, :class_name => "User", :foreign_key => "creator_id"
end