class CreateSports < ActiveRecord::Migration
  def change
    create_table :sports do |t|
      t.string :title
      t.string :icon

      t.timestamps
    end
  end
end
