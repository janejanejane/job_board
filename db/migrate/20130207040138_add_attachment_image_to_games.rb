class AddAttachmentImageToGames < ActiveRecord::Migration
  def change
    add_attachment :games, :image
  end
end
