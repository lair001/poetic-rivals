class CreatePoemVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :poem_votes do |t|
      t.integer :poem_id
      t.integer :value

      t.timestamps
    end
  end
end
