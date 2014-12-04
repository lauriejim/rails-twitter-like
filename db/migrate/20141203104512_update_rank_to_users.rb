class UpdateRankToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :rank
    add_column :users, :rank, :string, default: 'user'
  end
end
