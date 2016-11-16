class CreateRivalVictims < ActiveRecord::Migration[5.0]
  def change
    create_table :rival_victims do |t|
      t.integer :rival_id
      t.integer :victim_id

      t.timestamps
    end
  end
end
