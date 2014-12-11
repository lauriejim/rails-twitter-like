class RemoveColumns < ActiveRecord::Migration
  def change
    remove_column :events, :background
  end
end
