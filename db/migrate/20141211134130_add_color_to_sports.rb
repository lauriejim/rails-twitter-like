class AddColorToSports < ActiveRecord::Migration
  def change
    add_column :sports, :color, :string
  end
end
