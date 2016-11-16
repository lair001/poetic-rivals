class CreateFanIdols < ActiveRecord::Migration[5.0]
  def change
    create_table :fan_idols do |t|
      t.integer :fan_id
      t.integer :idol_id

      t.timestamps
    end
  end
end
