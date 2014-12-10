class DeleteLikesToEvent < ActiveRecord::Migration
  def change
    remove_column :events, :likes
  end
end
