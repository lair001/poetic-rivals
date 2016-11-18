class CreatePoemDownvotes < ActiveRecord::Migration[5.0]
  def change
    create_table :poem_downvotes do |t|
      t.integer :poem_id

      t.timestamps
    end
  end
end
