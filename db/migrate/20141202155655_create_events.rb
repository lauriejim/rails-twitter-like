class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :cover
      t.text :description
      t.string :adresse
      t.integer :likes

      t.timestamps
    end
  end
end
