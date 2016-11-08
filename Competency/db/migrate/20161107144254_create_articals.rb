class CreateArticals < ActiveRecord::Migration
  def change
    create_table :articals do |t|
      t.string :title
      t.text :content
      t.string :category
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
