class CreateAgendas < ActiveRecord::Migration[7.0]
  def change
    create_table :agendas do |t|
      t.string :title
      t.string :keywords, default: [], array: true

      t.timestamps
    end
  end
end
