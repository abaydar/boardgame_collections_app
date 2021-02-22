class CreateBoardgames < ActiveRecord::Migration[5.2]
  def change
    create_table :boardgames do |t|
      t.string :name
      t.integer :year_published
      t.string :image
      t.integer :min_players
      t.integer :max_players
      t.integer :playing_time
      t.belongs_to :user_boardgame
    end
  end
end
