class DropUserBoardgames < ActiveRecord::Migration[5.2]
  def change
    drop_table :user_boardgames
  end
end
