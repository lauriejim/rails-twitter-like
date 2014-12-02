class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :picture
      t.string :description
      t.string :rang

      t.timestamps
    end
  end
end
