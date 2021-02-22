class CreateUserBoardgame < ActiveRecord::Migration[5.2]
  def change
    create_table :user_boardgames do |t|
      t.belongs_to :user
      t.belongs_to :boardgames
    end
  end
end
