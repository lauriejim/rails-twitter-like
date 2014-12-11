class AddBackgroundToSports < ActiveRecord::Migration
  def change
    add_column :sports, :background, :string
  end
end
