class AddBackgroundToEvents < ActiveRecord::Migration
  def change
    add_column :events, :background, :string
  end
end
