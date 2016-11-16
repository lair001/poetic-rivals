class CreatePoemGenres < ActiveRecord::Migration[5.0]
  def change
    create_table :poem_genres do |t|
      t.integer :poem_id
      t.integer :genre_id

      t.timestamps
    end
  end
end
