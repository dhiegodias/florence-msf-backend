class CreateStakeholders < ActiveRecord::Migration[7.0]
  def change
    create_table :stakeholders do |t|
      t.string :name, null: false
      t.string :position
      t.string :twitter_handler
      t.string :instagram_handler
      t.string :role
      t.string :phone
      t.string :email
      t.string :organization

      t.timestamps
    end
  end
end
