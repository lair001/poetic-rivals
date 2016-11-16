class CreatePoems < ActiveRecord::Migration[5.0]
  def change
    create_table :poems do |t|
      t.integer :author_id
      t.string :title
      t.text :body
      t.boolean :private?, default: false

      t.timestamps
    end
  end
end
