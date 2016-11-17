class CreateGenres < ActiveRecord::Migration[5.0]
  def change
    create_table :genres do |t|
      t.string :name
      t.boolean :banned?, default: false

      t.timestamps
    end
  end
end
