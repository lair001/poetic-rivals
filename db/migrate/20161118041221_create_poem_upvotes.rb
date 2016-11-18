class CreatePoemUpvotes < ActiveRecord::Migration[5.0]
  def change
    create_table :poem_upvotes do |t|
      t.integer :poem_id

      t.timestamps
    end
  end
end
