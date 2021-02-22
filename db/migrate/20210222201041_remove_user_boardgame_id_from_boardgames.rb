class RemoveUserBoardgameIdFromBoardgames < ActiveRecord::Migration[5.2]
  def change
    remove_column :boardgames, :user_boardgame_id
  end
end
