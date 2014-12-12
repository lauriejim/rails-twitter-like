class AddPictureToUsers < ActiveRecord::Migration
  def change
    add_column :users, :picture, :string, :default => "user/default_profil.jpg"
  end
end
