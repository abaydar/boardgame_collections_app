class AddCreatorIdColumnToBoardgames < ActiveRecord::Migration[5.2]
  def change
    add_column :boardgames, :creator_id, :integer
  end
end
