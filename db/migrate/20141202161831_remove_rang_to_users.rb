class RemoveRangToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :rang
    add_column :users, :rank, :string
  end
end
