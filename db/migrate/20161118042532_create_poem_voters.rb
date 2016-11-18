class CreatePoemVoters < ActiveRecord::Migration[5.0]
  def change
    create_table :poem_voters do |t|
      t.integer :poem_id
      t.integer :voter_id
      t.integer :value

      t.timestamps
    end
  end
end
