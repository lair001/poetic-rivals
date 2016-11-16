class CreateCommentaries < ActiveRecord::Migration[5.0]
  def change
    create_table :commentaries do |t|
      t.integer :commentator_id
      t.integer :poem_id
      t.text :comment

      t.timestamps
    end
  end
end
